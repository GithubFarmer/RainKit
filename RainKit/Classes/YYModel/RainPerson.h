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


@interface RainPerson : NSObject<YYModel,RainPerson>

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *classID;

@end
