//
//  TuyaRNTimerModule.m
//  TuyaRnDemo
//
//  Created by 浩天 on 2019/2/28.
//  Copyright © 2019年 Facebook. All rights reserved.
//

#import "TuyaRNTimerModule.h"
#import <TuyaSmartTimerKit/TuyaSmartTimer.h>
#import <React/RCTBridgeModule.h>
#import "TuyaRNUtils.h"
#import <YYModel.h>

@interface TuyaRNTimerModule()
@property (nonatomic, strong) TuyaSmartTimer *timer;
@end

@implementation TuyaRNTimerModule

RCT_EXPORT_MODULE(TuyaTimerModule)

RCT_EXPORT_METHOD(initWithOptions:(NSDictionary *)params) {

}

RCT_EXPORT_METHOD(onDestory:(NSDictionary *)params) {

}

// 增加定时器,带有自己定义dp点：
RCT_EXPORT_METHOD(addTimerWithTask:(NSDictionary *)params resolver:(RCTPromiseResolveBlock)resolver rejecter:(RCTPromiseRejectBlock)rejecter) {
  TuyaSmartTimer *timer = [[TuyaSmartTimer alloc] init];
  self.timer = timer;

  [timer addTimerWithTask:params[@"taskName"] loops:params[@"loops"] bizId:params[@"devId"] bizType:0 time:params[@"time"] dps:params[@"dps"] status:YES isAppPush:NO aliasName:@"" success:^{
    if (resolver) {
      resolver(@"addTimerWithTask success");
    }
  } failure:^(NSError *error) {
    [TuyaRNUtils rejecterWithError:error handler:rejecter];
  }];
}


// 获取某设备下的所有定时任务状态：
RCT_EXPORT_METHOD(getTimerTaskStatusWithDeviceId:(NSDictionary *)params resolver:(RCTPromiseResolveBlock)resolver rejecter:(RCTPromiseRejectBlock)rejecter) {
    TuyaSmartTimer *timer = [[TuyaSmartTimer alloc] init];
    self.timer = timer;
    [timer getTimerTaskStatusWithDeviceId:params[@"devid"] success:^(NSArray<TYTimerTaskModel *> *list) {

      NSMutableArray *res = [NSMutableArray array];
      for (TYTimerTaskModel *item in list) {
        NSDictionary *dic = [item yy_modelToJSONObject];
        [res addObject:dic];
      }

      if (resolver) {
        resolver(res);
      }
    } failure:^(NSError *error) {
      [TuyaRNUtils rejecterWithError:error handler:rejecter];
    }];
}

// 控制定时任务中所有定时器的开关状态：
RCT_EXPORT_METHOD(updateTimerTaskStatusWithTask:(NSDictionary *)params resolver:(RCTPromiseResolveBlock)resolver rejecter:(RCTPromiseRejectBlock)rejecter) {
    TuyaSmartTimer *timer = [[TuyaSmartTimer alloc] init];
    self.timer = timer;
    [timer updateTimerTaskStatusWithTask:params[@"taskName"] bizId:params[@"devId"] bizType:0 updateType:[params[@"status"] integerValue] success:^{
      if (resolver) {
        resolver(@"success");
      }
    } failure:^(NSError *error) {
      [TuyaRNUtils rejecterWithError:error handler:rejecter];
    }];
}

// 控制某个定时器的开关状态：
RCT_EXPORT_METHOD(updateTimerStatusWithTask:(NSDictionary *)params resolver:(RCTPromiseResolveBlock)resolver rejecter:(RCTPromiseRejectBlock)rejecter) {
    TuyaSmartTimer *timer = [[TuyaSmartTimer alloc] init];
    self.timer = timer;

    NSInteger status = [params[@"isOpen"] boolValue]?1:0;

    [timer updateTimerStatusWithTask:params[@"taskName"] bizId:params[@"devId"] bizType:0 status:status success:^{
      if (resolver) {
        resolver(@"success");
      }
    } failure:^(NSError *error) {
      [TuyaRNUtils rejecterWithError:error handler:rejecter];
    }];
}

// 删除定时器：
RCT_EXPORT_METHOD(removeTimerWithTask:(NSDictionary *)params resolver:(RCTPromiseResolveBlock)resolver rejecter:(RCTPromiseRejectBlock)rejecter) {
    TuyaSmartTimer *timer = [[TuyaSmartTimer alloc] init];
    self.timer = timer;

    [timer removeTimerWithTask:params[@"taskName"] bizId:params[@"devId"] bizType:0 success:^{
      if (resolver) {
        resolver(@"success");
      }
    } failure:^(NSError *error) {
      [TuyaRNUtils rejecterWithError:error handler:rejecter];
    }];
}

// 更新定时器的状态：
RCT_EXPORT_METHOD(updateTimerWithTask:(NSDictionary *)params resolver:(RCTPromiseResolveBlock)resolver rejecter:(RCTPromiseRejectBlock)rejecter) {
    TuyaSmartTimer *timer = [[TuyaSmartTimer alloc] init];
    self.timer = timer;

    [timer updateTimerWithTimerId:params[@"timerId"] loops:params[@"loops"] bizId:params[@"devId"] bizType:0 time:params[@"time"] dps:params[@"dps"] status:YES isAppPush:NO aliasName:@"" success:^{
        if (resolver) {
          resolver(@"success");
        }
    } failure:^(NSError *error) {
      [TuyaRNUtils rejecterWithError:error handler:rejecter];
    }];
}

// 获取定时任务下所有定时器：
RCT_EXPORT_METHOD(getTimerWithTask:(NSDictionary *)params resolver:(RCTPromiseResolveBlock)resolver rejecter:(RCTPromiseRejectBlock)rejecter) {
    TuyaSmartTimer *timer = [[TuyaSmartTimer alloc] init];
    self.timer = timer;

    [timer getTimerListWithTask:params[@"taskName"] bizId:params[@"devId"] bizType:0 success:^(NSArray<TYTimerTaskModel *> *list) {

        NSMutableArray *res = [NSMutableArray array];
        for (TYTimerModel *item in list) {
          NSDictionary *dic = [item yy_modelToJSONObject];
          [res addObject:dic];
        }

        if (resolver) {
          resolver(res);
        }
    } failure:^(NSError *error) {
      [TuyaRNUtils rejecterWithError:error handler:rejecter];
    }];
}


// 获取设备所有定时任务下所有定时器：
RCT_EXPORT_METHOD(getAllTimerWithDeviceId:(NSDictionary *)params resolver:(RCTPromiseResolveBlock)resolver rejecter:(RCTPromiseRejectBlock)rejecter) {
     TuyaSmartTimer *timer = [[TuyaSmartTimer alloc] init];
    self.timer = timer;
    [timer getAllTimerWithDeviceId:params[@"devId"] success:^(NSDictionary *dict) {

      NSMutableArray *res = [NSMutableArray array];

      [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, NSArray* _Nonnull obj, BOOL * _Nonnull stop) {
        NSMutableArray *arr = [NSMutableArray array];

        NSMutableDictionary *timerTaskStatus = [NSMutableDictionary dictionary];
        timerTaskStatus[@"timerName"] = key;
        NSMutableDictionary *task = [NSMutableDictionary dictionary];
        task[@"timerTaskStatus"] = timerTaskStatus;

        if([obj isKindOfClass:[NSArray class]]) {
          for (TYTimerModel *item in obj) {
            NSMutableDictionary *dic = [item yy_modelToJSONObject];
            dic[@"timerId"] = item.timerId;
            dic[@"status"] = item.status?@(1):@(0);
            task[@"timerTaskStatus"][@"open"] = item.status?@(true):@(false);
            [arr addObject:dic];
          }
        }

        task[@"timerList"] = arr;
        [res addObject:task];
      }];
        if (resolver) {
          resolver(res);
        }
    } failure:^(NSError *error) {
      [TuyaRNUtils rejecterWithError:error handler:rejecter];
    }];
}

@end
