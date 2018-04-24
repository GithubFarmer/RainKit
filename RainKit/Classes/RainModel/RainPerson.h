//
//  RainPerson.h
//  RainKit
//
//  Created by 喻永权 on 2018/3/27.
//

#import <Foundation/Foundation.h>
#import <YYModel/YYModel.h>

@protocol RainPerson <NSObject>

@property (nonatomic, copy) NSString *personIntroduce;

@end


@protocol RainModelProtocol <NSObject>

@property (nonatomic, copy) NSString *person;
@property (nonatomic, copy) NSString *info;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, copy) NSString *name;


@end

@interface RainObject : NSObject

@property (nonatomic, copy) NSString *pName;
@property (nonatomic, assign) NSInteger pAge;

@end


/**
 YYModel的运用
 */
@interface RainPerson : NSObject<YYModel,RainPerson,RainModelProtocol>

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *classID;

@property (nonatomic, copy) NSArray <RainObject *> *personArray;

@end


