//
//  ViewController.m
//  CalculateQueryComplexity
//
//  Created by CYH on 2017/6/29.
//  Copyright © 2017年 Lianxi.com. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *startsArray;
@property (nonatomic, strong) NSMutableArray *endsArray;
@property (nonatomic, strong) NSMutableArray *queryArray;
@property (nonatomic, strong) NSMutableDictionary *mapMutaleDictionary;
@property (nonatomic, strong) NSMutableArray *resultArray;

@end

@implementation ViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

//生成数组_startsArray、_endsArray、_queryArray（随机）
- (NSMutableArray *)startsArray{
    if (!_startsArray) {
        _startsArray = [NSMutableArray arrayWithCapacity:1];
//        for (NSInteger i = 0; i < 10; i ++) {
//            [_startsArray addObject:@(i)];
//        }
        [_startsArray addObject:@(0)];
        [_startsArray addObject:@(5)];
        [_startsArray addObject:@(2)];
    }
    return _startsArray;
}

- (NSMutableArray *)endsArray{
    if (!_endsArray) {
        _endsArray = [NSMutableArray arrayWithCapacity:1];
//        for (NSInteger i = 10; i < 20; i ++) {
//            [_endsArray addObject:@(i)];
//        }
        [_endsArray addObject:@(4)];
        [_endsArray addObject:@(7)];
        [_endsArray addObject:@(8)];
    }
    return _endsArray;
}

- (NSMutableArray *)queryArray{
    if (!_queryArray) {
        _queryArray = [NSMutableArray arrayWithCapacity:1];
//        for (NSInteger i = 0; i < 10; i ++) {
//            [_queryArray addObject:@((arc4random()%100))];
//        }
        [_queryArray addObject:@(1)];
        [_queryArray addObject:@(9)];
        [_queryArray addObject:@(4)];
        [_queryArray addObject:@(3)];
    }
    return _queryArray;
}

- (NSMutableDictionary *)mapMutaleDictionary{
    if (!_mapMutaleDictionary) {
        _mapMutaleDictionary = [NSMutableDictionary dictionaryWithCapacity:1];
    }
    return _mapMutaleDictionary;
}

- (NSMutableArray *)resultArray{
    if (!_resultArray) {
        _resultArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _resultArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /*
     大致思路: 建立一个 key-value 的映射，字典中 key 值唯一
     1、_startsArray 数组元素 与 _endsArray 数组元素个数相等 ，也就是题目中的 n
     2、m 是所要查询的 _queryArray 的元素的个数
     3、计算：[左区间：闭，右区间：开)
        ①以[[_endsArray objectAtIndex:i] integerValue] - [[_startsArray objectAtIndex:i] integerValue] 区间的每一个 integer 的值作为 key，
        ②或者说是 以[[_startsArray objectAtIndex:i] integerValue]为起始key值，[[_endsArray objectAtIndex:i] integerValue]为值为某次循环的最大次数 key 值
        ③然后，每循环一次，取出 key 值对应的 value，然后++value
        ④setValue:forKey
        ⑤这样就得出一个以 query 数组中元素为 key 值，这些元素存在于那两个数组区间内的次数为 value 的映射表
        ⑥最后，从这个映射表中，查询对应元素的次数
     */
    //PS:
    //计算出(左区间：闭，右区间：开) [start1,end1),....,[startn,endn) 区间值 建立一个 key-value 的映射
    for (NSInteger i = 0; i < self.startsArray.count; i ++) {
        for (NSInteger j = [self.startsArray[i] integerValue]; j < [self.endsArray[i] integerValue]; j ++) {
            NSInteger value = [[self.mapMutaleDictionary valueForKey:[NSString stringWithFormat:@"%ld",j]] integerValue];
            ++value;
            [self.mapMutaleDictionary setValue:@(value) forKey:[NSString stringWithFormat:@"%ld",j]];
        }
        NSLog(@"");
    }
    NSLog(@"mapMutaleDictionary : %@",self.mapMutaleDictionary);
    
    NSLog(@"query : %@",self.queryArray);
    //通过映射
    for (NSInteger i = 0; i < self.queryArray.count; i ++) {
        NSInteger query = [self.queryArray[i] integerValue];
        NSInteger value = [[self.mapMutaleDictionary valueForKey:[NSString stringWithFormat:@"%ld",query]] integerValue];
        [self.resultArray addObject:@(value)];
    }
    NSLog(@"resultArray : %@",self.resultArray);
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
