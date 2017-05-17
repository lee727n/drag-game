//
//  ViewController.m
//  拖拽图片
//
//  Created by Mikez on 2017/4/28.
//  Copyright © 2017年 Mikez. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *rightView;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imageViews;
@property (weak, nonatomic) IBOutlet UIView *leftView;
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (nonatomic, strong)UIImageView *dragIV;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
   
    UITouch *t = [touches anyObject];
    CGPoint p = [t locationInView:self.view];
    
    
    //判断p点 点击的是哪个图片
    for (UIImageView *iv in self.imageViews) {
        
        if (CGRectContainsPoint(iv.frame, p)) {
            
            //[iv removeFromSuperview];
            
            UIImageView *dragIV = [[UIImageView alloc]initWithFrame:iv.frame];
            dragIV.image = iv.image;
            [self.view addSubview:dragIV];
            self.dragIV = dragIV;
            dragIV.userInteractionEnabled = YES;
            //创建点击手势
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
            [dragIV addGestureRecognizer:tap];
         
        }
        
    }
}

- (void)tapAction:(UITapGestureRecognizer *)tap{
    
    
    if ([tap.view.superview isEqual:self.leftView]) {
        //把点击到的view删除
        [tap.view removeFromSuperview];
        self.leftLabel.text = @(self.leftView.subviews.count).stringValue;
    }else{
        //把点击到的view删除
        [tap.view removeFromSuperview];
        self.rightLabel.text = @(self.rightView.subviews.count).stringValue;
    }
    
    
    
    
    
    
    
    
    
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *t = [touches anyObject];
    CGPoint p = [t locationInView:self.view];
    
    self.dragIV.center = p;
    
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if (CGRectContainsPoint(self.leftView.frame, self.dragIV.center)) {
        //得到相对于self.view的点
        CGPoint oldCenter = self.dragIV.center;
        //把相对于self.view的点转换成相对于leftView的点
        CGPoint newCenter = [self.view convertPoint:oldCenter toView:self.leftView];
        [self.leftView addSubview:self.dragIV];
        
        self.dragIV.center = newCenter;
        
        self.leftLabel.text = @(self.leftView.subviews.count).stringValue;
    }else if (CGRectContainsPoint(self.rightView.frame, self.dragIV.center)) {
        CGPoint oldCenter = self.dragIV.center;
        //把相对于self.view的点转换成相对于leftView的点
        CGPoint newCenter = [self.view convertPoint:oldCenter toView:self.rightView];
        [self.rightView addSubview:self.dragIV];
        self.dragIV.center = newCenter;
        self.rightLabel.text = @(self.rightView.subviews.count).stringValue;
    }else{//没有在view里松手
        
        [self.dragIV removeFromSuperview];
        
        
    }
    self.dragIV = nil;
}


@end
