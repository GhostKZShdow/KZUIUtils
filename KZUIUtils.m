//
//  LongWatchUIUtils.m
//  lvpai1.0
//
//  Created by 张坤 on 15/9/22.
//  Copyright (c) 2015年 KZ. All rights reserved.
//

#import "KZUIUtils.h"
#import "AFNetworking.h"

@implementation KZUIUtils

//屏幕的宽
+ (CGFloat)getWindowWidth{
    UIWindow *window=[UIApplication sharedApplication].windows[0];
    return window.bounds.size.width;
}

//屏幕的高
+ (CGFloat)getWindowHeight{
    UIWindow *window=[UIApplication sharedApplication].windows[0];
    return window.bounds.size.height;
}

//判断字符串是否为空
+ (BOOL)isBlankString:(NSString *)string{
    if (string==nil) {
        return YES;
    }
    if (string==NULL) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}
//开启实时监控网络
+ (void)webReachAbility{
    // 1.获得网络监控的管理者
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    
    // 2.设置网络状态改变后的处理
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态改变了, 就会调用这个block
        switch (status) {
            case AFNetworkReachabilityStatusUnknown: // 未知网络
                NSLog(@"未知网络");
                break;
                
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                NSLog(@"没有网络(断网)");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
                NSLog(@"手机自带网络");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                NSLog(@"WIFI");
                break;
        }
    }];
    // 3.开始监控
    [mgr startMonitoring];
}
//获取网络状态
+ (networkStatus)getNetworkStatus{
    networkStatus netStatus;
    // 1.获得网络监控的管理者
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    //2.判断网络状态
    if (mgr.isReachable) {//有网
        if (mgr.isReachableViaWiFi) {//Wifi
            NSLog(@"wifi");
            netStatus = networkWifi;
        } else {//流量
            netStatus = networkGG;
            NSLog(@"流量");
        }
    } else {//网络未连接
        netStatus = networkStroken;
        NSLog(@"无网络");
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NoNetworking" object:nil];
    }
    return netStatus;
}
//字符串
+ (NSString *)arrayConvertToString:(NSArray *)array{
    //把数组转换为字符串
    NSError *error;
    NSData *textData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
    NSString *textString = [[NSString alloc] initWithData:textData encoding:NSUTF8StringEncoding];
    return textString;
}

//字符串转换成数组
+ (NSArray *)stringConvertToArray:(NSString *)string{
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    return array;
}

//计算文本的高度
+ (CGFloat)getTextHeight:(NSString *)text width:(CGFloat)width font:(UIFont *)font{
    CGRect textRect = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    
    return textRect.size.height;
}

//计算textView的高度
+ (CGFloat)getTextViewHeight:(NSString *)text font:(UIFont *)font width:(CGFloat)width{
    //初始化textView
    UITextView *textView = [[UITextView alloc]init];
    [textView setText:text];
    [textView setFont:font];
    CGSize size = [textView sizeThatFits:CGSizeMake(width, MAXFLOAT)];
    return size.height;
}

//获取当前的时间戳
+ (NSString *)getCurrentDateLine{
    //时区（中国时区 东八区）
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    //当前时区和格林尼治所在时区相差时间的秒数 （8小时 28800秒）
    NSTimeInterval delta = [zone secondsFromGMTForDate:[NSDate date]];
    //当前时区的时间到格林尼治时间的秒数（格林尼治的时间戳+28800秒）
    NSString *string = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970] + delta];
    //去掉毫秒数
    NSString *dateString = [[string componentsSeparatedByString:@"."]objectAtIndex:0];
    return dateString;
}

//时间戳转换成当前时区的日期
+ (NSString *)getDateFromDateLine:(NSString *)dateLine format:(NSString *)format{
    //上传时的时间戳（格林尼治时间戳）
    NSString *timeIntervalSince1970 = dateLine;
    //把时间戳转化成日期（格林尼治日期）
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeIntervalSince1970 intValue]];
    
    //初始化时间格式
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    //给时间格式设置时区（东八区）
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:timeZone];
    //给时间格式设置日期格式
    //YYYY:MM:dd-HH:mm:ss
    [dateFormatter setDateFormat:format];
    NSString *timeString = [dateFormatter stringFromDate:date];
    return timeString;
}

//获取当前时区的时间
+ (NSString *)getCurrentDate2:(NSString *)format{
    //格林尼治日期
    NSDate *date = [NSDate date];
    //初始化时间格式
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    //给时间格式设置时区（东八区）
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:timeZone];
    //给时间格式设置日期格式
    //YYYY:MM:dd-HH:mm:ss
    [dateFormatter setDateFormat:format];
    //获取date对应dateFormatter格式的字符串
    NSString *timeString = [dateFormatter stringFromDate:date];
    return timeString;
}

//根据两个坐标点的位置和计算得到的角度返回一个要旋转的角度
+ (float)angleWithFirstCoor:(CLLocationCoordinate2D)firCoor SecondCoor:(CLLocationCoordinate2D)secCoor{
    float angle = atan((secCoor.latitude - firCoor.latitude)/(secCoor.longitude - firCoor.longitude));
    //第一种情况
    if (firCoor.longitude<secCoor.longitude && firCoor.latitude==secCoor.latitude) {
        angle = 0;
    }
    //第二种情况
    else if (angle>0 && angle<M_PI_2 && firCoor.longitude<secCoor.longitude && firCoor.latitude<secCoor.latitude) {
        angle = 0 - angle;
    }
    //第三种情况
    else if (firCoor.longitude==secCoor.longitude && firCoor.latitude<secCoor.latitude){
        angle = -M_PI_2;
    }
    //第四种情况
    else if (angle>-M_PI_2 && angle<0 && firCoor.longitude>secCoor.longitude && firCoor.latitude<secCoor.latitude){
        angle = 0 - (M_PI + angle);
    }
    //第五种情况
    else if (firCoor.longitude>secCoor.longitude && firCoor.latitude==secCoor.latitude){
        angle = M_PI;
        //        angle = -M_PI;
    }
    //第六种情况
    else if (angle>0 && angle<M_PI_2 && firCoor.longitude>secCoor.longitude && firCoor.latitude>secCoor.latitude){
        angle = angle + M_PI_2;
        //        angle = 0 - (M_PI + angle);
    }
    //第七种情况
    else if (firCoor.longitude==secCoor.longitude && firCoor.latitude>secCoor.latitude){
        angle = M_PI_2;
        //        angle = M_PI_2 * 3;
    }
    //第八种情况
    else if (angle>-M_PI_2 && angle<0 && firCoor.longitude<secCoor.longitude && firCoor.latitude>secCoor.latitude){
        angle = 0 - angle;
        //        angle = 0 - (M_PI_2 * 3 - angle);
    }
    //第九种情况
    else if (firCoor.longitude==secCoor.longitude && firCoor.latitude==firCoor.longitude){
        angle = 0;
    }
    return angle;
}

//拨打电话
+ (void)callWithView:(UIView *)view button:(UIButton *)button{
    NSString *urlString = [NSString stringWithFormat:@"tel:%@",button.titleLabel.text];
    NSURL *url = [NSURL URLWithString:urlString];
    UIWebView *webView = [[UIWebView alloc]init];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    [view addSubview:webView];
}

//拨打电话
+ (void)callWithView:(UIView *)view label:(UILabel *)label{
    NSString *urlString = [NSString stringWithFormat:@"tel:%@",label.text];
    NSURL *url = [NSURL URLWithString:urlString];
    UIWebView *webView = [[UIWebView alloc]init];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    [view addSubview:webView];
}

//给button上的文字添加下划线
+ (void)addUnderLine:(UIButton *)button{
    NSString *title = button.titleLabel.text;
    NSDictionary *attributeDic = @{NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    if (title.length) {
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:title attributes:attributeDic];
        button.titleLabel.attributedText = attributeString;
    }
}

//给label上的文字添加下划线
+ (void)addLabelUnderLine:(UILabel *)label{
    NSString *title = label.text;
    NSDictionary *attributeDic = @{NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    if (title.length) {
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:title attributes:attributeDic];
        label.attributedText = attributeString;
    }
}
//HUD标题
+ (void)showReminderMBProgressHUDWithTitle:(NSString *)title view:(UIView *)view{
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:HUD];
    HUD.labelText = title;
    HUD.mode = MBProgressHUDModeText;
    
    //指定距离中心点的X轴和Y轴的偏移量，如果不指定则在屏幕中间显示
    //        HUD.yOffset = 150.0f;
    //        HUD.xOffset = 100.0f;
    
    [HUD showAnimated:YES whileExecutingBlock:^{
        sleep(1.5);
    } completionBlock:^{
        [HUD removeFromSuperview];
    }];
}
//完全复制一个view
+ (id)duplicate:(id)view {
    NSData * tempArchive = [NSKeyedArchiver archivedDataWithRootObject:view];
    return [NSKeyedUnarchiver unarchiveObjectWithData:tempArchive];
}
//判断一个字符串是否都是汉字
+ (BOOL)isAllChineseInString:(NSString *)str{
    for (int i=0; i<str.length; i++) {
        unichar ch = [str characterAtIndex:i];
        if (0x4e00 > ch || ch > 0x9fff) {
            return false;
        }
    }
    return true;
}
@end
