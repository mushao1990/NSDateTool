//  Created by 慕少锋 on 2018/10/7.
//  Copyright © 2018年 慕少锋. All rights reserved.

#import "NSDate+MSTool.h"

static NSString * MS_CalendarCustomIdentifierConstant = nil;
#define MS_SharedCalendar (MS_CalendarCustomIdentifierConstant)?[NSCalendar calendarWithIdentifier:MS_CalendarCustomIdentifierConstant] : [NSCalendar currentCalendar]

@implementation NSDate (MSTool)

+ (void)ms_configTheDefaultCalendarWithIdentifier:(NSCalendarIdentifier)calendarIdentifierConstant {
    MS_CalendarCustomIdentifierConstant = calendarIdentifierConstant;
}

// 根据年月日生成日期
+ (nullable NSDate *)ms_dateFromYear:(NSInteger)year Month:(NSInteger)month Day:(NSInteger)day Hour:(NSInteger)hour Minutes:(NSInteger)minutes Seconds:(NSInteger)seconds {
    NSDateComponents * comps = [[NSDateComponents alloc] init];
    [comps setValue:year forComponent:NSCalendarUnitYear];
    [comps setValue:month forComponent:NSCalendarUnitMonth];
    [comps setValue:day forComponent:NSCalendarUnitDay];
    [comps setValue:hour forComponent:NSCalendarUnitHour];
    [comps setValue:minutes forComponent:NSCalendarUnitMinute];
    [comps setValue:seconds forComponent:NSCalendarUnitSecond];
    return [self ms_dateFromComponents:comps];
}

+ (nullable NSDate *)ms_dateFromComponents:(NSDateComponents *)comps {
    return [MS_SharedCalendar dateFromComponents:comps];
}

// 调整时间获取日期 第一个参数传负值相当于获取之前的日期
- (nullable NSDate *)ms_dateByAddingSeconds:(NSInteger)seconds {    
    return [MS_SharedCalendar dateByAddingUnit:NSCalendarUnitSecond value:seconds toDate:self options:NSCalendarMatchStrictly];
}

- (nullable NSDate *)ms_dateByAddingMinutes:(NSInteger)minutes {
    return [MS_SharedCalendar dateByAddingUnit:NSCalendarUnitMinute value:minutes toDate:self options:NSCalendarMatchStrictly];
}

- (nullable NSDate *)ms_dateByAddingHours:(NSInteger)hours {
    return [MS_SharedCalendar dateByAddingUnit:NSCalendarUnitHour value:hours toDate:self options:NSCalendarMatchStrictly];
}

- (nullable NSDate *)ms_dateByAddingMonths:(NSInteger)months {
    return [MS_SharedCalendar dateByAddingUnit:NSCalendarUnitMonth value:months toDate:self options:NSCalendarMatchStrictly];
}

- (nullable NSDate *)ms_dateByAddingDays:(NSInteger)days {
    return [MS_SharedCalendar dateByAddingUnit:NSCalendarUnitDay value:days toDate:self options:NSCalendarMatchStrictly];
}

- (nullable NSDate *)ms_dateByAddingYears:(NSInteger)year {
    return [MS_SharedCalendar dateByAddingUnit:NSCalendarUnitYear value:year toDate:self options:NSCalendarMatchStrictly];
}

- (nullable NSDate *)ms_dateByAddingComponents:(NSDateComponents *)comps {
    return [MS_SharedCalendar dateByAddingComponents:comps toDate:self options:NSCalendarMatchStrictly];
}

// 获取日期的开始时间 例：2018-09-09 00：00：00
- (nullable NSDate *)ms_startOfDay {
    return [MS_SharedCalendar startOfDayForDate:self];
}

// 获取日期的年月日时分秒
- (NSInteger)ms_seconds {
    return [MS_SharedCalendar component:NSCalendarUnitSecond fromDate:self];
}

- (NSInteger)ms_minute {
    return [MS_SharedCalendar component:NSCalendarUnitMinute fromDate:self];
}

- (NSInteger)ms_hour {
    return [MS_SharedCalendar component:NSCalendarUnitHour fromDate:self];
}

- (NSInteger)ms_day {
    return [MS_SharedCalendar component:NSCalendarUnitDay fromDate:self];
}

- (NSInteger)ms_month {
    return [MS_SharedCalendar component:NSCalendarUnitMonth fromDate:self];
}

- (NSInteger)ms_week {
    return [MS_SharedCalendar component:NSCalendarUnitWeekday fromDate:self];
}

- (NSInteger)ms_year {
    return [MS_SharedCalendar component:NSCalendarUnitYear fromDate:self];
}

// 简单的时间字符串
- (NSString *)ms_weekDays {
    NSInteger week = [self ms_week];
    NSString * weekString = @"";
    switch (week) {
        case 1:
            weekString = @"星期日";
            break;
        case 2:
            weekString = @"星期一";
            break;
        case 3:
            weekString = @"星期二";
            break;
        case 4:
            weekString = @"星期三";
            break;
        case 5:
            weekString = @"星期四";
            break;
        case 6:
            weekString = @"星期五";
            break;
        case 7:
            weekString = @"星期六";
            break;
            
        default:
            break;
    }
    return weekString;
}

- (NSString *)ms_timesString {
    
    NSString * dateString = [self ms_stringWithFormat:@"yyyy-MM-dd"];
    NSString * timeString = [self ms_stringWithFormat:@"HH:mm"];
    NSString * preStr = dateString;
    BOOL isToday = [self ms_isToday];
    BOOL isTommorrow = [self ms_isTomorrow];
    BOOL isYesterDay = [self ms_isYesterDay];

    if (isToday) {
        preStr = @"今天";
    }
    else if (isTommorrow) {
        preStr = @"明天";
    }
    else if (isYesterDay) {
        preStr = @"昨天";
    }

    return [NSString stringWithFormat:@"%@ %@",preStr,timeString];
}

- (NSString *)ms_timesAgo {
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:self];
    if (timeInterval < 0) {
        return @"";
    }
    if (timeInterval < 60) {
        return @"刚刚";
    }
    else if (timeInterval >= 60 && timeInterval < 60*60) {
        return [NSString stringWithFormat:@"%.0f分钟前",timeInterval/60];
    }
    else if (timeInterval >= 60*60 && timeInterval < 24*60*60) {
        return [NSString stringWithFormat:@"%.0f小时前",timeInterval/(60*60)];
    }
    else {
        return [self ms_timesString];
    }
}

// 是否和某个日期一样
- (BOOL)ms_isSameAsDate:(NSDate *)anotherDate {
    return [self compare:anotherDate] == NSOrderedSame;
}

- (BOOL)ms_isSameAsDate:(NSDate *)anotherDate inSomeUnit:(NSCalendarUnit)unit {
    return [MS_SharedCalendar isDate:anotherDate equalToDate:self toUnitGranularity:unit];
}

- (BOOL)ms_isToday {
    return [MS_SharedCalendar isDateInToday:self];
}

- (BOOL)ms_isYesterDay {
    return [MS_SharedCalendar isDateInYesterday:self];
}

- (BOOL)ms_isTomorrow {
    return [MS_SharedCalendar isDateInTomorrow:self];
}

- (BOOL)ms_isWeekend {
    return [MS_SharedCalendar isDateInWeekend:self];
}

+ (nullable NSDate *)ms_earlierDate:(NSArray<NSDate *> *)dates {
    NSDate * earlierDate = nil;
    NSInteger totalCount = dates.count;
    for (NSInteger i = 0; i < totalCount; i++) {
        if (i == 0) {
            earlierDate = dates[i];
            break;
        }
        NSDate * currentDate = dates[i];
        earlierDate = [earlierDate earlierDate:currentDate];
    }
    return earlierDate;
}

+ (nullable NSDate *)ms_laterDate:(NSArray<NSDate *> *)dates {
    NSDate * laterDate = nil;
    NSInteger totalCount = dates.count;
    for (NSInteger i = 0; i < totalCount; i++) {
        if (i == 0) {
            laterDate = dates[i];
            break;
        }
        NSDate * currentDate = dates[i];
        laterDate = [laterDate laterDate:currentDate];
    }
    return laterDate;
}

// 时间字符串和日期相互转换
- (nullable NSString *)ms_stringWithFormat:(NSString *)format {
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format;
    formatter.calendar = MS_SharedCalendar;
    return [formatter stringFromDate:self];
}

+ (nullable NSDate *)ms_dateFromString:(NSString *)timeString WithTimeFormat:(NSString *)format {
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format;
    formatter.calendar = MS_SharedCalendar;
    return [formatter dateFromString:timeString];
}

// 根据时间戳生成日期
+ (nullable NSDate *)ms_dateFromTimestamp:(NSTimeInterval)timestamp {
    if (timestamp >= 1000000000 && timestamp < 10000000000) { // 10位
        return [NSDate dateWithTimeIntervalSince1970:timestamp];
    }
    else if (timestamp >= 1000000000000 && timestamp < 10000000000000) { // 13位
        return [NSDate dateWithTimeIntervalSince1970:timestamp/1000.0];
    }
    return nil;
}

// 判断日期是否在所给日期范围内
- (BOOL)isContainedBetweenStartDate:(NSDate *)startDate andEndDate:(NSDate *)endDate {
    NSComparisonResult startResult = [startDate compare:self];
    NSComparisonResult endResult = [endDate compare:self];
    return (startResult != NSOrderedDescending && endResult != NSOrderedAscending);
}

- (BOOL)isContainedInStartDate:(NSDate *)startDate andDuration:(NSTimeInterval)timeInterval {
    NSDate * endDate = [startDate dateByAddingTimeInterval:timeInterval];
    return [self isContainedBetweenStartDate:startDate andEndDate:endDate];
}

@end
