//
//  SegmentTapView.m
//  SegmentTapView

#import "SegmentTapView.h"
#import "MMBadgeView.h"
#define kLineImageView_HEIGHT 3 //下滑线的高度
//#define kLineImageView_LEFT ([UIScreen mainScreen].bounds.size.width/12)

@interface SegmentTapView ()
@property (nonatomic, strong)NSMutableArray *buttonsArray;
@property (nonatomic, strong)UIImageView *lineImageView;
@property (nonatomic, assign)CGFloat width;
@property (nonatomic, assign)CGFloat x;;

@end
@implementation SegmentTapView

-(instancetype)initWithFrame:(CGRect)frame withDataArray:(NSArray *)dataArray withFont:(CGFloat)font {
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        self.backgroundColor = [UIColor whiteColor];
        _buttonsArray = [[NSMutableArray alloc] init];
        _dataArray = dataArray;
        _titleFont = font;
        
        //默认
        self.textNomalColor    = [UIColor blackColor];
        self.textSelectedColor = [UIColor redColor];
        self.lineColor = [UIColor redColor];
        
        [self addSubSegmentView];
    }
    return self;
}

-(void)addSubSegmentView
{
    float width = self.frame.size.width / _dataArray.count;
    for (int i = 0 ; i < _dataArray.count ; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(i * width, 0, width, self.frame.size.height)];
        [self addSubview:view];
        MMBadgeView *button = [MMBadgeView new];
        button.frame = CGRectMake(0, 0, 0, self.frame.size.height);
        button.badgeValue = _dataArray[i];
        button.center = view.center;
        button.tag = i+1;
//        button.backgroundColor = [UIColor clearColor];
        [button setTitleColor:self.textNomalColor    forState:UIControlStateNormal];
        [button setTitleColor:self.textSelectedColor forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:_titleFont];
        [button addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
        //默认第一个选中
        if (i == 0) {
            self.x = button.frame.origin.x;//记录初始button x坐标
            self.width = button.frame.size.width;//记录初始button宽度
            button.selected = YES;
        }
        else{
            button.selected = NO;
        }
        [self.buttonsArray addObject:button];
        [self addSubview:button];
        
        //间隔线
     /*
        if (i != _dataArray.count || i != 0) {
            UILabel *line = [[UILabel alloc ] initWithFrame:CGRectMake(i * width , 0, 0.45, 40)];
            line.backgroundColor = [UIColor blackColor];
            [self bringSubviewToFront:line];
            [self addSubview:line];
        }
      */
    }
    self.lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.x, self.frame.size.height-kLineImageView_HEIGHT -1 , self.width, kLineImageView_HEIGHT)];
    self.lineImageView.backgroundColor = _lineColor;
    [self addSubview:self.lineImageView];
}
-(void)tapAction:(id)sender{
    UIButton *button = (UIButton *)sender;
    [UIView animateWithDuration:0.2 animations:^{
       self.lineImageView.frame = CGRectMake(button.frame.origin.x , self.frame.size.height-kLineImageView_HEIGHT - 1, button.frame.size.width , kLineImageView_HEIGHT);
    }];
    for (UIButton *subButton in self.buttonsArray) {
        if (button == subButton) {
            subButton.selected = YES;
        }
        else{
            subButton.selected = NO;
        }
    }
    if ([self.delegate respondsToSelector:@selector(selectedIndex:)]) {
        [self.delegate selectedIndex:button.tag -1];
    }
}
-(void)selectIndex:(NSInteger)index
{
    for (UIButton *subButton in self.buttonsArray) {
        if (index != subButton.tag) {
            subButton.selected = NO;
        }
        else{
            subButton.selected = YES;
            [UIView animateWithDuration:0.3 animations:^{
                self.lineImageView.frame = CGRectMake(subButton.frame.origin.x , self.frame.size.height-kLineImageView_HEIGHT - 1, subButton.frame.size.width , kLineImageView_HEIGHT);
            }];
        }
    }
}
#pragma mark -- set
-(void)setLineColor:(UIColor *)lineColor{
    if (_lineColor != lineColor) {
        self.lineImageView.backgroundColor = lineColor;
        _lineColor = lineColor;
    }
}
-(void)setTextNomalColor:(UIColor *)textNomalColor{
    if (_textNomalColor != textNomalColor) {
        for (UIButton *subButton in self.buttonsArray){
            [subButton setTitleColor:textNomalColor forState:UIControlStateNormal];
        }
        _textNomalColor = textNomalColor;
    }
}
-(void)setTextSelectedColor:(UIColor *)textSelectedColor{
    if (_textSelectedColor != textSelectedColor) {
        for (UIButton *subButton in self.buttonsArray){
            [subButton setTitleColor:textSelectedColor forState:UIControlStateSelected];
        }
        _textSelectedColor = textSelectedColor;
    }
}
-(void)setTitleFont:(CGFloat)titleFont{
    if (_titleFont != titleFont) {
        for (UIButton *subButton in self.buttonsArray){
            subButton.titleLabel.font = [UIFont systemFontOfSize:titleFont] ;
        }
        _titleFont = titleFont;
    }
}
@end
