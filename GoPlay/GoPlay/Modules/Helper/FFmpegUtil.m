//
//  FFmpegUtil.m
//  GoPlay
//
//  Created by 肖湘 on 2023/8/15.
//  Copyright © 2023 dKingbin. All rights reserved.
//

#import "FFmpegUtil.h"

#include <libavcodec/avcodec.h>
#include <libavformat/avformat.h>
#include <libavutil/imgutils.h>
#include <libswscale/swscale.h>

int save_frame_as_png(AVFrame *pFrame, int width, int height, const char *filename) {
    AVOutputFormat *ofmt = av_guess_format("image2", ".png", "image/png");
    AVFormatContext *oc = NULL;
    AVStream *st;
    AVCodecContext *c;
    AVCodec *codec;
    int ret;

    if (!ofmt) {
        fprintf(stderr, "Could not determine output format\n");
        return -1;
    }

    avformat_alloc_output_context2(&oc, ofmt, NULL, filename);
    if (!oc) {
        fprintf(stderr, "Could not create output context\n");
        return -1;
    }

    st = avformat_new_stream(oc, 0);
    if (!st) {
        fprintf(stderr, "Could not create new stream\n");
        return -1;
    }

    codec = avcodec_find_encoder(AV_CODEC_ID_PNG);
    if (!codec) {
        fprintf(stderr, "PNG codec not found\n");
        return -1;
    }

    c = avcodec_alloc_context3(codec);
    if (!c) {
        fprintf(stderr, "Could not allocate codec context\n");
        return -1;
    }

    st->codecpar->codec_type = AVMEDIA_TYPE_VIDEO;
    st->codecpar->width = width;
    st->codecpar->height = height;
    st->codecpar->format = AV_PIX_FMT_RGB24;
    st->codecpar->codec_id = AV_CODEC_ID_PNG;

    if (oc->oformat->flags & AVFMT_GLOBALHEADER) {
        c->flags |= AV_CODEC_FLAG_GLOBAL_HEADER;
    }

    // Set the time base for the codec context
    c->time_base = (AVRational){1, 25};

    ret = avcodec_open2(c, codec, NULL);
    if (ret < 0) {
        fprintf(stderr, "Could not open codec\n");
        return -1;
    }

    ret = avio_open(&oc->pb, filename, AVIO_FLAG_WRITE);
    if (ret < 0) {
        fprintf(stderr, "Could not open file %s\n", filename);
        return -1;
    }

    ret = avformat_write_header(oc, NULL);
    if (ret < 0) {
        fprintf(stderr, "Error writing header\n");
        return -1;
    }

    AVPacket pkt = { 0 };
    int got_packet;
    avcodec_encode_video2(c, &pkt, pFrame, &got_packet);

    if (got_packet) {
        av_interleaved_write_frame(oc, &pkt);
        av_packet_unref(&pkt);
    }

    av_write_trailer(oc);

    avcodec_close(c);
    av_free(c);
    avio_close(oc->pb);
    avformat_free_context(oc);

    return 0;
}

int capture_frame(const char *video_path, const char *output_path) {
    AVFormatContext *pFormatCtx = NULL;
    AVCodecContext *pCodecCtx = NULL;
    AVCodec *pCodec = NULL;
    AVFrame *pFrame = NULL;
    AVFrame *pFrameRGB = NULL;
    struct SwsContext *sws_ctx = NULL;
    int videoStream, numBytes;
    uint8_t *buffer = NULL;

    // Register all formats and codecs
    av_register_all();

    // Open video file
    if (avformat_open_input(&pFormatCtx, video_path, NULL, NULL) != 0)
        return -1; // Couldn't open file

    // Retrieve stream information
    if (avformat_find_stream_info(pFormatCtx, NULL) < 0)
        return -1; // Couldn't find stream information

    // Find the first video stream
    videoStream = -1;
    for (int i = 0; i < pFormatCtx->nb_streams; i++)
        if (pFormatCtx->streams[i]->codecpar->codec_type == AVMEDIA_TYPE_VIDEO) {
            videoStream = i;
            break;
        }
    if (videoStream == -1)
        return -1; // Didn't find a video stream

    // Get a pointer to the codec context for the video stream
    pCodecCtx = avcodec_alloc_context3(NULL);
    if (!pCodecCtx)
        return -1;

    avcodec_parameters_to_context(pCodecCtx, pFormatCtx->streams[videoStream]->codecpar);

    // Find the decoder for the video stream
    pCodec = avcodec_find_decoder(pCodecCtx->codec_id);
    if (pCodec == NULL)
        return -1; // Codec not found

    // Open codec
    if (avcodec_open2(pCodecCtx, pCodec, NULL) < 0)
        return -1; // Could not open codec

    // Allocate video frame
    pFrame = av_frame_alloc();

    // Allocate an AVFrame structure
    pFrameRGB = av_frame_alloc();
    if (pFrameRGB == NULL)
        return -1;

    // Determine required buffer size and allocate buffer
    numBytes = av_image_get_buffer_size(AV_PIX_FMT_RGB24, pCodecCtx->width,
                                        pCodecCtx->height, 1);
    buffer = (uint8_t *)av_malloc(numBytes * sizeof(uint8_t));

    av_image_fill_arrays(pFrameRGB->data, pFrameRGB->linesize, buffer,
                         AV_PIX_FMT_RGB24, pCodecCtx->width, pCodecCtx->height, 1);

    // Read frames and save first five frames to disk
    int frameFinished;
    AVPacket packet;

    // Seek to the desired timestamp (in this case, the beginning)
    av_seek_frame(pFormatCtx, videoStream, 0, AVSEEK_FLAG_ANY);

    sws_ctx = sws_getContext(pCodecCtx->width, pCodecCtx->height, pCodecCtx->pix_fmt,
                             pCodecCtx->width, pCodecCtx->height, AV_PIX_FMT_RGB24,
                             SWS_BILINEAR, NULL, NULL, NULL);

    while (av_read_frame(pFormatCtx, &packet) >= 0) {
        // Is this a packet from the video stream?
        if (packet.stream_index == videoStream) {
            // Decode video frame
            avcodec_decode_video2(pCodecCtx, pFrame, &frameFinished, &packet);

            // Did we get a video frame?
            if (frameFinished) {
                // Convert the image from its native format to RGB
                sws_scale(sws_ctx, (uint8_t const * const *)pFrame->data,
                          pFrame->linesize, 0, pCodecCtx->height,
                          pFrameRGB->data, pFrameRGB->linesize);

                // Save the frame to disk
                if (save_frame_as_png(pFrameRGB, pCodecCtx->width, pCodecCtx->height, output_path) == 0) {
                    break;
                }
            }
        }
        // Free the packet that was allocated by av_read_frame
        av_packet_unref(&packet);
    }

    // Free the RGB image
    av_free(buffer);
    av_free(pFrameRGB);

    // Free the YUV frame
    av_free(pFrame);

    // Close the codecs
    avcodec_close(pCodecCtx);

    // Close the video file
    avformat_close_input(&pFormatCtx);

    return 0;
}

@implementation FFmpegUtil
+ (instancetype)sharedInstance {
    static FFmpegUtil *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[FFmpegUtil alloc] init];
    });
    return instance;
}

+(NSString *)captureFrame:(NSString *)videoPath{
    // Convert NSString to a C string
   const char *video_path_cstr = [videoPath UTF8String];
   // Derive the output path. Here's a simple way using the video's name,
   // but you can customize this as needed.
   NSString *outputDirectory = [videoPath stringByDeletingLastPathComponent];
   NSString *outputFileName = [[[videoPath lastPathComponent] stringByDeletingPathExtension]
                                stringByAppendingString:@"_frame.png"];
   NSString *outputPath = [outputDirectory stringByAppendingPathComponent:outputFileName];

   const char *output_path_cstr = [outputPath UTF8String];

   int result = capture_frame(video_path_cstr, output_path_cstr);
   if (result == 0) {
       return outputPath;  // Return the path of the saved PNG frame
   } else {
       // Handle error, return nil or a specific error message
       return nil;
   }
}
@end

