//
//  LongWatchUIUtils.h
//  lvpai1.0
//
//  Created by 张坤 on 15/9/22.
//  Copyright (c) 2015年 KZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
typedef enum {
    networkStroken = 0,//断网
    networkGG = 1,//流量
    networkWifi = 2,//wifi
    networkUnKnown = 3//未知网络
}networkStatus;

@interface KZUIUtils : NSObject
/*－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－*/
+ (CGFloat)getWindowWidth;
/*－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－*/
+ (CGFloat)getWindowHeight;
/*－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－*/
//判断字符串是否为空
+ (BOOL)isBlankString:(NSString *)string;
/*－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－*/
//开启网络实时监控
+ (void)webReachAbility;
/*－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－*/
/**
 *  判断网络状态
 *
 *  @return 当前的网络状态
 */
+ (networkStatus)getNetworkStatus;
/*－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－*/
/**
 *  数组转换成字符串
 *
 *  @param array 数组
 *
 *  @return 返回数组转换的字符串
 */
+ (NSString *)arrayConvertToString:(NSArray *)array;
/*－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－*/
/**
 *  字符串转换成数组
 *
 *  @param string 要转换的字符串
 *
 *  @return 转换后的数组
 */
+ (NSArray *)stringConvertToArray:(NSString *)string;
/*－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－*/
/**
 *  计算文本的高度
 *
 *  @param text  文本
 *  @param width 固定宽度
 *  @param font  文本字体
 *
 *  @return 文本的高度
 */
+ (CGFloat)getTextHeight:(NSString *)text width:(CGFloat)width font:(UIFont *)font;
/*－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－*/
/**
 *  计算textView的高度
 *
 *  @param text  textView的内容
 *  @param font  textView的字体
 *  @param width textView的宽度
 *
 *  @return textView的高度
 */
+ (CGFloat)getTextViewHeight:(NSString *)text font:(UIFont *)font width:(CGFloat)width;
/*－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－*/
/**
 *  获取当前的时间戳
 *
 *  @return 时间戳
 */
+ (NSString *)getCurrentDateLine;
/*－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－*/
/**
 *  把时间戳转换成日期
 *
 *  @param dateLine 时间戳
 *  @param format  所要转换日期的格式（YYYY:MM:dd-HH:mm:ss）
 *
 *  @return 日期
 */
+ (NSString *)getDateFromDateLine:(NSString *)dateLine format:(NSString *)format;
/*－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－*/
/**
 *  获取当前时区的时间
 *
 *  @param format 日期格式
 *
 *  @return 返回当前时区的时间
 */
+ (NSString *)getCurrentDate2:(NSString *)format;
/*－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－*/
/**
 *  根据两个坐标点的位置和计算得到的角度返回一个要旋转的角度－
 *  需要引入<CoreLocation/CoreLocation.h>框架  2015-12-10
 *
 *  @param firCoor 第一个坐标点
 *  @param secCoor 第二个坐标点
 *  @param angle   由两个坐标点计算得到的角度
 *
 *  @return 实际要旋转的角度
 */
+ (float)angleWithFirstCoor:(CLLocationCoordinate2D)firCoor SecondCoor:(CLLocationCoordinate2D)secCoor;
/*－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－*/
/**
 *  拨打电话
 *
 *  @param view   父view
 *  @param button 显示号码的button
 */
+ (void)callWithView:(UIView *)view button:(UIButton *)button;
/*－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－*/
/**
 *  拨打电话
 *
 *  @param view  父view
 *  @param label 显示号码的label
 */
+ (void)callWithView:(UIView *)view label:(UILabel *)label;
/*－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－*/
/**
 *  给button上的文字添加下划线
 *
 *  @param button 要添加文字的button
 */
/*－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－*/
+ (void)addUnderLine:(UIButton *)button;
/**
 *  给label上的文字添加下划线
 *
 *  @param label 要添加下划线的label
 */
+ (void)addLabelUnderLine:(UILabel *)label;
/**
 *  HUD标题
 *
 *  @param title 标题
 *  @param view  展示的位置
 */
+ (void)showReminderMBProgressHUDWithTitle:(NSString *)title view:(UIView *)view;
/**
 *  完全复制一个view
 *
 *  @param view 要复制的view
 *
 *  @return 复制后的view
 */
+ (id)duplicate:(id)view;
/**
 *  判断字符串中是否都是汉字
 *
 *  @param str 要判断的字符串
 *
 *  @return YES or No
 */
+ (BOOL)isAllChineseInString:(NSString *)str;
@end
