//
//  User.m
//  手机银行
//
//  Created by Gate on 16/1/17.
//  Copyright © 2016年 Gate. All rights reserved.
//

#import "User.h"

@implementation User

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_mobile forKey:@"mobile"];
    [aCoder encodeObject:_sex forKey:@"sex"];
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeObject:_photo forKey:@"photo"];
    [aCoder encodeObject:_answer forKey:@"answer"];
    [aCoder encodeObject:_birthday forKey:@"birthday"];
    [aCoder encodeObject:_password forKey:@"password"];
    [aCoder encodeObject:_createTime forKey:@"createTime"];
    [aCoder encodeObject:_id forKey:@"id"];
    [aCoder encodeObject:_updateTime forKey:@"updateTime"];
    [aCoder encodeObject:_amount forKey:@"amount"];

}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.mobile = [aDecoder decodeObjectForKey:@"mobile"];
        self.sex = [aDecoder decodeObjectForKey:@"sex"];
        self.photo = [aDecoder decodeObjectForKey:@"photo"];
        self.answer = [aDecoder decodeObjectForKey:@"answer"];
        self.birthday = [aDecoder decodeObjectForKey:@"birthday"];
        self.amount = [aDecoder decodeObjectForKey:@"amount"];
        self.password = [aDecoder decodeObjectForKey:@"password"];
        self.createTime = [aDecoder decodeObjectForKey:@"createTime"];
        self.id = [aDecoder decodeObjectForKey:@"id"];
        self.updateTime = [aDecoder decodeObjectForKey:@"updateTime"];

    }
    return self;
}
@end
