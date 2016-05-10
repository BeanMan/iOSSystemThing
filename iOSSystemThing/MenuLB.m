//
//  MenuLB.m
//  uuu
//
//  Created by bean on 16/5/4.
//  Copyright © 2016年 com.xile. All rights reserved.
//

#import "MenuLB.h"

@implementation MenuLB

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib
{
    // 给Label添加手机
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick)]];
}

-(instancetype)initWithFrame:(CGRect)rect
{
    if(self = [super initWithFrame:rect])
    {
        // 给Label添加手机
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick)]];
    }
    return self;
}

- (void)labelClick
{
    // 让label成为第一响应者
    [self becomeFirstResponder];
    
    // 获得菜单
    UIMenuController *menu = [UIMenuController sharedMenuController];
    
    // 设置菜单内容，显示中文，所以要手动设置app支持中文
    menu.menuItems = @[
                       [[UIMenuItem alloc] initWithTitle:@"顶" action:@selector(ding:)],
                       [[UIMenuItem alloc] initWithTitle:@"回复" action:@selector(reply:)],
                       [[UIMenuItem alloc] initWithTitle:@"举报" action:@selector(warn:)]
                       ];
    
    // 菜单最终显示的位置
    [menu setTargetRect:self.bounds inView:self];
    
    // 显示菜单
    [menu setMenuVisible:YES animated:YES];
}

#pragma mark - UIMenuController相关
/**
 * 让Label具备成为第一响应者的资格
 */
- (BOOL)canBecomeFirstResponder
{
    return YES;
}

/**
 * 通过第一响应者的这个方法告诉UIMenuController可以显示什么内容
 */
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if ( (action == @selector(copy:) && self.text) // 需要有文字才能支持复制
        || (action == @selector(cut:) && self.text) // 需要有文字才能支持剪切
        || action == @selector(paste:)
        || action == @selector(ding:)
        || action == @selector(reply:)
        || action == @selector(warn:)) return YES;
    
    return NO;
}

#pragma mark - 监听MenuItem的点击事件
- (void)cut:(UIMenuController *)menu
{
    // 将label的文字存储到粘贴板
    [UIPasteboard generalPasteboard].string = self.text;
    // 清空文字
    self.text = nil;
    
    
    NSLog(@"剪切%@",self.text);
}

- (void)copy:(UIMenuController *)menu
{
    // 将label的文字存储到粘贴板
    [UIPasteboard generalPasteboard].string = self.text;
    NSLog(@"复制%@",self.text);
}

- (void)paste:(UIMenuController *)menu
{
    // 将粘贴板的文字赋值给label
    self.text = [UIPasteboard generalPasteboard].string;
    NSLog(@"粘贴%@",self.text);
}

- (void)ding:(UIMenuController *)menu
{
    NSLog(@"顶%s %@", __func__, menu);
}

- (void)reply:(UIMenuController *)menu
{
    NSLog(@"回复%s %@", __func__, menu);
}

- (void)warn:(UIMenuController *)menu
{
    NSLog(@"举报%s %@", __func__, menu);
}
@end
