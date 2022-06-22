import {
  Platform,
  NativeEventEmitter,
  DeviceEventEmitter,
  NativeModules,
} from 'react-native';

export const GROUPLISTENER = 'groupListener';
export const HARDWAREUPGRADELISTENER = 'hardwareUpgradeListener';
export const DEVLISTENER = 'devListener';
export const SUBDEVLISTENER = 'subDevListener';
export const HOMESTATUS = 'homeStatus';
export const HOMECHANGE = 'homeChange';
export const SINGLETRANSFER = 'SingleTransfer';

const EventEmitter = Platform.select({
  android: DeviceEventEmitter,
  ios: new NativeEventEmitter(NativeModules['TuyaRNEventEmitter'])
})
 
export function addEvent(eventname: string, callback: (data: any) => any) {
  if (Platform.OS === 'android') {
    EventEmitter!.addListener(eventname, callback)
  } else {
    const ret = EventEmitter!.addListener(eventname, callback);
    (ret as any).callback = callback
    return ret
  }
  return;
}

export function removeEvent(eventname: string, sub: any) {
  if (Platform.OS === 'android') {
    EventEmitter!.removeListener(eventname, sub)
  } else {
    try {
      console.log('remove sub', sub, sub && sub.remove)
      //EventEmitter!.removeSubscription(sub)
      if (sub) {
        const callback = sub.callback
        EventEmitter!.removeListener(eventname, callback)
        sub.remove()
      }
    } catch (e) {
      console.log('remove Event error', e)
    }
  }
}

export const bridge = (key: string, id: string | number) => `${key}//${id}`;