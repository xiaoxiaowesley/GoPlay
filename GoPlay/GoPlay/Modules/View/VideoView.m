//
//  VideoView.m
//  GoPlay
//
//  Created by dKingbin on 2018/11/20.
//  Copyright © 2018年 dKingbin. All rights reserved.
//

#import "VideoView.h"
#include <objc/objc.h>
#import <MediaPlayer/MediaPlayer.h>

#import "FFHeader.h"
#import "ColorUtil.h"
#import "CommonUtil.h"
#import "Masonry.h"
#import "ReactiveCocoa.h"
#import "CommonUtil.h"
#import "GoPlay-Swift.h"

typedef enum {
    sd_vertical_left = 0,
    sd_vertical_right ,
    sd_horizontal ,
} SwipeDirection;

#define PLAYING @"\u{e616}"
#define PAUSED @"\u{e615}"
#define NEXT @"\u{e607}"
#define FORMAER @"\u{e606}"

//5 seconds
const static int kCountdownToHideNum = 5;

@interface VideoView()
@property(nonatomic,strong) UIButton* goBackBtn; // 返回按钮
@property(nonatomic,strong) UISlider* slider;  // 进度条
@property(nonatomic,strong) UIButton* playBtn; // 播放按钮
@property(nonatomic,strong) UIButton* formerBtn; // 前一个按钮
@property(nonatomic,strong) UIButton* nextBtn; // 下一个按钮
@property(nonatomic,strong) UIButton* rotateBtn; // 旋转按钮

@property(nonatomic,strong) NSMutableArray* landscapeControls;
@property(nonatomic,assign) int countdownToHide;
@property(nonatomic,assign) BOOL isControlsHidden;
@property(nonatomic,assign) SwipeDirection direction;

@property(nonatomic,strong) UIPanGestureRecognizer* pan;
@end

@implementation VideoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if(self)
    {
        self.backgroundColor = UIColor.clearColor;
        self.countdownToHide = kCountdownToHideNum;
        self.isControlsHidden = NO;
        self.isPanning = NO;
        
        self.isPlay = YES;
        
        [self addSubviews];
        [self defineLayouts];
        [self setupObservers];
    }
    
    return self;
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Method
- (void)setIsPlay:(BOOL)isPlay
{
    _isPlay = isPlay;
    
    if(isPlay)
    {
        // [self.playBtn setImage:[UIImage imageNamed:@"gg_pause_icon"] forState:UIControlStateNormal];
        [self.playBtn setTitle:PAUSED  forState:UIControlStateNormal];
    }
    else
    {
        // [self.playBtn setImage:[UIImage imageNamed:@"gg_play_icon"] forState:UIControlStateNormal];
        [self.playBtn setTitle:PLAYING forState:UIControlStateNormal];
        
    }
    
    self.countdownToHide = kCountdownToHideNum;
}

- (void)setIsControlsHidden:(BOOL)isControlsHidden
{
    _isControlsHidden = isControlsHidden;
    
    [self.landscapeControls enumerateObjectsUsingBlock:^(UIView*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.hidden = isControlsHidden;
    }];
}

- (void)updateSliderValue:(float)value
{
    self.slider.value = value;
}

- (void)disablePanGesture
{
    self.pan.enabled = NO;
}

- (void)enablePanGesture
{
    self.pan.enabled = YES;
}

- (void)addSubviews
{
    [self addControls:self.goBackBtn];
    [self addControls:self.titleLabel];
    [self addControls:self.slider];
    [self addControls:self.playBtn];
    [self addControls:self.nextBtn];
    [self addControls:self.formerBtn];
    //    [self addControls:self.vrBtn];
    //    [self addControls:self.filterBtn];
    [self addControls:self.timeLabel];
    [self addControls:self.rotateBtn];
}

- (void)addControls:(UIView *)view
{
    [self.landscapeControls addObject:view];
    [self addSubview:view];
}

- (void)defineLayouts
{
    // 获取当前设备是否竖屏/横屏，并赋值给isPortrait
    BOOL isPortrait = UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].windows.firstObject.windowScene.interfaceOrientation);
    // 返回按钮
    [self.goBackBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        // 如果当前是竖屏，而且是刘海屏，top的边距需要加30
        if (isPortrait && [UIDevice isNotch]) {
            make.top.equalTo(self).offset(30+20);
        }else{
            make.top.equalTo(self).offset(20);
        }
        
        make.left.equalTo(self).offset(15);
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];
    
    //标题
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goBackBtn.mas_right).offset(10);
        make.right.mas_equalTo(44+10);
        make.height.mas_equalTo(44);
        make.centerY.equalTo(self.goBackBtn.mas_centerY);
    }];
    
    double bottom = 0;
    double horizonSpace = 50;
    if (isPortrait && [UIDevice isNotch]) {
        bottom = [UIDevice safeAreaInsets].bottom;
    }
    
    bottom += 20;
    
    [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(16);
        make.bottom.equalTo(self).offset(-60-bottom);
        make.left.equalTo(self).offset(horizonSpace);
        make.right.equalTo(self).offset(-horizonSpace);
    }];
        
    [self.formerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(horizonSpace);
        make.bottom.equalTo(self).offset(-bottom);
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];
    
    [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.formerBtn).offset(horizonSpace);
        make.bottom.equalTo(self).offset(-bottom);
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];
    
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.playBtn).offset(horizonSpace);
        make.bottom.equalTo(self).offset(-bottom);
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];
    
    
    //    [self.vrBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.centerY.equalTo(self.playBtn);
    //        make.left.equalTo(self.playBtn.mas_right).offset(15);
    //    }];
    //
    //    [self.filterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.centerY.equalTo(self.playBtn);
    //        make.left.equalTo(self.playBtn.mas_right).offset(15);
    //        make.size.mas_equalTo(CGSizeMake(34, 34));
    //    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nextBtn.mas_right).offset(15);
        make.centerY.equalTo(self.nextBtn);
    }];
    
    [self.rotateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self);
    }];
}

- (void)setupObservers
{
    @weakify(self)
    [[self.goBackBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(id x) {
        @strongify(self)
        if(self.didGoBack)
        {
            self.didGoBack();
        }
    }];
    
    [[self.playBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(id x) {
        @strongify(self)
        self.isPlay = !self.isPlay;
        if(self.didPlay)
        {
            self.didPlay();
        }
    }];

    [[self.formerBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(id x) {
        @strongify(self)
        if(self.didFormer)
        {
            self.didFormer();
        }
    }];

    [[self.nextBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(id x) {
        @strongify(self)
        if(self.didNext)
        {
            self.didNext();
        }
    }];
    
    
    //    [[self.vrBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
    //     subscribeNext:^(id x) {
    //        @strongify(self)
    //        if(self.didVR)
    //        {
    //            self.didVR();
    //        }
    //    }];
    
    //    [[self.filterBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
    //     subscribeNext:^(id x) {
    //        @strongify(self)
    //        if(self.didFilter)
    //        {
    //            self.didFilter();
    //        }
    //    }];
    
    [[self.slider rac_signalForControlEvents:UIControlEventTouchDown]
     subscribeNext:^(id x) {
        @strongify(self)
        self.isDragging = YES;
    }];
    
    [[self.slider rac_signalForControlEvents:UIControlEventValueChanged]
     subscribeNext:^(id x) {
        @strongify(self)
        if(self.didSeeking)
        {
            self.didSeeking(self.slider.value);
        }
    }];
    
    [[[self.slider rac_signalForControlEvents:UIControlEventTouchUpInside]
      merge:[self.slider rac_signalForControlEvents:UIControlEventTouchUpOutside]]
     subscribeNext:^(id x) {
        @strongify(self)
        self.isDragging = NO;
        if(self.didSeek)
        {
            self.didSeek(self.slider.value);
        }
    }];
    
    [[self.rotateBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(id x) {
        @strongify(self)
        if(self.didRotate)
        {
            self.didRotate();
        }
    }];
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]init];
    [self addGestureRecognizer:tap];
    [tap.rac_gestureSignal subscribeNext:^(id x) {
        @strongify(self)
        self.isControlsHidden = !self.isControlsHidden;
        if (!self.isControlsHidden)
        {
            self.countdownToHide = kCountdownToHideNum;
        }
    }];
    
    UITapGestureRecognizer* doubleTap = [[UITapGestureRecognizer alloc]init];
    doubleTap.numberOfTapsRequired = 2;
    [self addGestureRecognizer:doubleTap];
    [doubleTap.rac_gestureSignal subscribeNext:^(id x) {
        @strongify(self)
        self.isPlay = !self.isPlay;
        if(self.didPlay)
        {
            self.didPlay();
        }
    }];
    [tap requireGestureRecognizerToFail:doubleTap];
    
    UIPanGestureRecognizer* pan = [[UIPanGestureRecognizer alloc]init];
    pan.minimumNumberOfTouches = 1;
    pan.maximumNumberOfTouches = 1;
    [self addGestureRecognizer:pan];
    self.pan = pan;
    
    [pan.rac_gestureSignal subscribeNext:^(UIPanGestureRecognizer* gesture) {
        @strongify(self)
        
        if(self.isControlsHidden) return;
        
        self.countdownToHide = -1;
        CGPoint velocityPt = [gesture velocityInView:gesture.view];
        CGPoint location = [gesture locationInView:gesture.view];
        
        if(gesture.state == UIGestureRecognizerStateBegan)
        {
            if(fabs(velocityPt.x) <= fabs(velocityPt.y))
            {
                //vertical
                if(location.x <= kScreenWidth/2.0)
                {
                    self.direction = sd_vertical_left;
                    
                    //brightness
                    self.tipsView.type = tt_brightness;
                    
                    float brightness = [UIScreen mainScreen].brightness;
                    [self.tipsView updateValue:brightness];
                    
                    [self.tipsView showAt:self];
                }
                else
                {
                    self.direction = sd_vertical_right;
                    
                    //volume
                    self.tipsView.type = tt_volume;
                    [self.tipsView updateValue:self.volume];
                    
                    [self.tipsView showAt:self];
                }
            }
            else
            {
                //horizontal
                self.direction = sd_horizontal;
                
                if(velocityPt.x >= 0)
                {
                    self.tipsView.type = tt_seektime_forward;
                }
                else
                {
                    self.tipsView.type = tt_seektime_backward;
                }
                
                //update time
                if(self.didHorizontalStartPan)
                {
                    self.didHorizontalStartPan();
                }
                
                self.isPanning = YES;
                
                [self.tipsView showAt:self];
            }
        }
        else if(gesture.state == UIGestureRecognizerStateChanged)
        {
            float verticalOffset = -velocityPt.y / 10000.0f;
            float horizontalOffset = velocityPt.x / 800.0f;
            
            if(self.direction == sd_vertical_left)
            {
                //brightness
                float value = [self.tipsView currentValue];
                value += verticalOffset;
                if(value < 0) value = 0;
                if(value > 1) value = 1;
                
                [self.tipsView updateValue:value];
                [UIScreen mainScreen].brightness = value;
            }
            else if(self.direction == sd_vertical_right)
            {
                //volume
                float value = [self.tipsView currentValue];
                value += verticalOffset;
                if(value < 0) value = 0;
                if(value > 1) value = 1;
                
                [self.tipsView updateValue:value];
                
                if(self.didUpdateVolume)
                {
                    self.didUpdateVolume(value);
                    self.volume = value;
                }
            }
            else if(self.direction == sd_horizontal)
            {
                if(velocityPt.x >= 0)
                {
                    self.tipsView.type = tt_seektime_forward;
                }
                else
                {
                    self.tipsView.type = tt_seektime_backward;
                }
                
                if(self.didHorizontalPanning)
                {
                    self.didHorizontalPanning(horizontalOffset);
                }
            }
        }
        else if(gesture.state == UIGestureRecognizerStateEnded)
        {
            self.countdownToHide = kCountdownToHideNum;
            [self.tipsView hide];
            
            if(self.direction == sd_horizontal)
            {
                if(self.didHorizontalEndPan)
                {
                    self.didHorizontalEndPan();
                }
                
                self.isPanning = NO;
            }
        }
    }];
    
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(ffPeriodicTime:) name:kFFPeriodicTimeNotificationKey object:nil];
}

- (void)ffPeriodicTime:(NSNotification *)notification
{
    if(self.isDragging || self.isPanning) return;
    
    NSDictionary *userInfo = [notification userInfo];
    NSNumber* time = userInfo[@"time"];
    NSNumber* duration = userInfo[@"duration"];
    
    [self hideControlsIfNecessary];
    float value = time.floatValue / duration.floatValue;
    
    if(value <= self.slider.value) return;
    [self updateSliderValue:value];
    
    //time
    [self updateTime:time.floatValue duration:duration.floatValue];
}

- (void)updateTime:(float)time duration:(float)duration
{
    int t_time = time;
    int d_duration = duration;
    
    long t_min = t_time / 60;
    long t_sec = t_time % 60;
    long d_min = d_duration / 60;
    long d_sec = d_duration % 60;
    self.timeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld/%02ld:%02ld", t_min, t_sec,d_min,d_sec];
}

- (void)hideControlsIfNecessary
{
    if(self.isControlsHidden) return;
    
    if(self.countdownToHide == -1)
    {
        self.isControlsHidden = NO;
    }
    else if(self.countdownToHide == 0)
    {
        self.isControlsHidden = YES;
    }
    else
    {
        self.countdownToHide--;
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isKindOfClass:[UISlider class]] ||
        [touch.view isKindOfClass:[UIButton class]])
    {
        // prevent recognizing touches on the slider
        return NO;
    }
    
    return YES;
}

#pragma mark - Buttons

- (UIButton *)goBackBtn
{
    if(!_goBackBtn)
    {
        _goBackBtn = [[UIButton alloc]init];
        [_goBackBtn setImage:[UIImage imageNamed:@"gg_back_icon"] forState:UIControlStateNormal];
    }
    
    return _goBackBtn;
}

- (UISlider *)slider
{
    if(!_slider)
    {
        _slider = [[UISlider alloc]init];
        _slider.minimumValue = 0;
        _slider.maximumValue = 1;
        [_slider setThumbImage:[UIImage imageNamed:@"play_progressbar"] forState:UIControlStateNormal];
    }
    return _slider;
}

- (UIButton *)playBtn
{
    if(!_playBtn)
    {
        _playBtn = [[UIButton alloc]init];
        _playBtn.titleLabel.font = [UIFont fontWithName:@"flat-ui-pro-icons" size:20];
        [_playBtn setTitle:PAUSED forState:UIControlStateNormal];
    }
    
    return _playBtn;
}
-(UIButton *)nextBtn{
    if(!_nextBtn){
        _nextBtn = [[UIButton alloc]init];
        //设置titile
        _nextBtn.titleLabel.font = [UIFont fontWithName:@"flat-ui-pro-icons" size:20];
        [_nextBtn setTitle:NEXT forState:UIControlStateNormal];
    }
    return _nextBtn;
}

- (UIButton *)formerBtn
{
    if(!_formerBtn)
    {
        _formerBtn = [[UIButton alloc]init];
        //设置titile
        _formerBtn.titleLabel.font = [UIFont fontWithName:@"flat-ui-pro-icons" size:20];
        [_formerBtn setTitle:FORMAER forState:UIControlStateNormal];
    }
    
    return _formerBtn;
}
//- (UIButton *)vrBtn
//{
//    if(!_vrBtn)
//    {
//        _vrBtn = [[UIButton alloc]init];
//        [_vrBtn setImage:[UIImage imageNamed:@"gg_vr_icon"] forState:UIControlStateNormal];
//    }
//
//    return _vrBtn;
//}

//- (UIButton *)filterBtn
//{
//    if(!_filterBtn)
//    {
//        _filterBtn = [[UIButton alloc]init];
//        [_filterBtn setImage:[UIImage imageNamed:@"gg_copyright_icon"] forState:UIControlStateNormal];
//    }
//
//    return _filterBtn;
//}

-(UIButton *)rotateBtn{
    if(!_rotateBtn)
    {
        _rotateBtn = [[UIButton alloc]init];
        [_rotateBtn setTitle:@"旋转" forState:UIControlStateNormal];
        [_rotateBtn setBackgroundColor:[UIColor redColor]];
    }
    return _rotateBtn;
}

- (UILabel *)timeLabel
{
    if(!_timeLabel)
    {
        _timeLabel = [CommonUtil LabelWithTitle:@"00:00/00:00"
                                      textColor:[UIColor whiteColor]
                                        bgColor:[UIColor clearColor]
                                           font:15
                                  textAlignment:NSTextAlignmentLeft
                                           Bold:NO];
        [_timeLabel sizeToFit];
    }
    
    return _timeLabel;
}

- (TipsView *)tipsView
{
    if(!_tipsView)
    {
        _tipsView = [[TipsView alloc]init];
    }
    return _tipsView;
}

- (NSMutableArray *)landscapeControls
{
    if(!_landscapeControls)
    {
        _landscapeControls = [NSMutableArray array];
    }
    
    return _landscapeControls;
}

-(UILabel*)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc]init];
    }
    return _titleLabel;
}


@end
