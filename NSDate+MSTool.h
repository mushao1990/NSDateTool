//  Created by 慕少锋 on 2018/10/7.
//  Copyright © 2018年 慕少锋. All rights reserved.

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface NSDate (MSTool)
/**
 配置默认的日历 ，如果不调用该方法，默认使用的是用户系统设置的日历
 @param calendarIdentifierConstant 各个区域的日历参数
 */
+ (void)ms_configTheDefaultCalendarWithIdentifier:(NSCalendarIdentifier)calendarIdentifierConstant;

// 根据年月日生成日期
+ (nullable NSDate *)ms_dateFromYear:(NSInteger)year Month:(NSInteger)month Day:(NSInteger)day Hour:(NSInteger)hour Minutes:(NSInteger)minutes Seconds:(NSInteger)seconds;
+ (nullable NSDate *)ms_dateFromComponents:(NSDateComponents *)comps;

// 调整时间获取日期 第一个参数传负值相当于获取之前的日期
- (nullable NSDate *)ms_dateByAddingSeconds:(NSInteger)seconds;
- (nullable NSDate *)ms_dateByAddingMinutes:(NSInteger)minutes;
- (nullable NSDate *)ms_dateByAddingHours:(NSInteger)hours;
- (nullable NSDate *)ms_dateByAddingMonths:(NSInteger)months;
- (nullable NSDate *)ms_dateByAddingDays:(NSInteger)days;
- (nullable NSDate *)ms_dateByAddingYears:(NSInteger)year;
- (nullable NSDate *)ms_dateByAddingComponents:(NSDateComponents *)comps;

// 获取日期的开始时间 例：2018-09-09 00：00：00
- (nullable NSDate *)ms_startOfDay;

// 获取日期的年月日时分秒
- (NSInteger)ms_seconds;
- (NSInteger)ms_minute;
- (NSInteger)ms_hour;
- (NSInteger)ms_day;
- (NSInteger)ms_month;
- (NSInteger)ms_week;
- (NSInteger)ms_year;

// 简单的时间字符串
- (NSString *)ms_weekDays;
- (NSString *)ms_timesString;
- (NSString *)ms_timesAgo;

// 是否和某个日期一样
- (BOOL)ms_isSameAsDate:(NSDate *)anotherDate;
- (BOOL)ms_isSameAsDate:(NSDate *)anotherDate inSomeUnit:(NSCalendarUnit)unit;

- (BOOL)ms_isToday;
- (BOOL)ms_isYesterDay;
- (BOOL)ms_isTomorrow;
- (BOOL)ms_isWeekend;

+ (nullable NSDate *)ms_earlierDate:(NSArray<NSDate *> *)dates;// 获取数组里最小的时间
+ (nullable NSDate *)ms_laterDate:(NSArray<NSDate *> *)dates;// 获取数组里最大的时间

// 时间字符串和日期相互转换
- (nullable NSString *)ms_stringWithFormat:(NSString *)format;
+ (nullable NSDate *)ms_dateFromString:(NSString *)timeString WithTimeFormat:(NSString *)format;

// 根据时间戳生成日期 一般时间戳都是10位或13位，这里只考虑10位或13位的情况
+ (nullable NSDate *)ms_dateFromTimestamp:(NSTimeInterval)timestamp;

// 判断日期是否在所给日期范围内
- (BOOL)isContainedBetweenStartDate:(NSDate *)startDate andEndDate:(NSDate *)endDate;
- (BOOL)isContainedInStartDate:(NSDate *)startDate andDuration:(NSTimeInterval)timeInterval;

@end

NS_ASSUME_NONNULL_END
