import { NativeModules, EmitterSubscription } from 'react-native';
import { addEvent, removeEvent, bridge, DEVLISTENER } from './bridgeUtils';

const tuya = NativeModules.TuyaDeviceModule;

export type DeviceBean = {
  productId: string;
  devId: string;
  verSw: string;
  name: string;
  dps: DeviceDps;
};

export type DevListenerParams = {
  devId: string;
};

export type DevListenerType =
  | 'onDpUpdate'
  | 'onRemoved'
  | 'onStatusChanged'
  | 'onNetworkStatusChanged'
  | 'onDevInfoUpdate'
  | 'onFirmwareUpgradeSuccess'
  | 'onFirmwareUpgradeFailure'
  | 'onFirmwareUpgradeProgress';

let devListenerSubs: { [devId: string]: EmitterSubscription | undefined } = {};

export function registerDevListener(
  params: DevListenerParams,
  type: DevListenerType,
  callback: (data: any) => void
) {
  tuya.registerDevListener(params);
  const sub = addEvent(bridge(DEVLISTENER, params.devId), data => {
    if (data.type === type) {
      callback(data);
    }
  });
  devListenerSubs[params.devId] = sub;
}

export function unRegisterAllDevListeners() {
  for (const devId in devListenerSubs) {
    const sub = devListenerSubs[devId];
    removeEvent(bridge(DEVLISTENER, devId), sub);
    delete devListenerSubs[devId];
    tuya.unRegisterDevListener({ devId });
  }
  devListenerSubs = {};
}

export function unRegisterDevListener(filter: any) {
    const devId = filter.devId as string;
    const sub = devListenerSubs[devId];
    removeEvent(bridge(DEVLISTENER, devId), sub);
    tuya.unRegisterDevListener({ devId });
    delete devListenerSubs[devId];
}

export type DeviceDpValue = boolean | number | string;
export type DeviceDps = {
  [dpId: string]: DeviceDpValue;
};
export type SendParams = {
  devId: string;
} & DeviceDps;

export function send(params: object) {
  return tuya.send(params);
}

export function publishDps(params: object) {
  return tuya.publishDps(params);
}

export type RemoveDeviceParams = { devId: string };

export function removeDevice(params: RemoveDeviceParams): Promise<string> {
  return tuya.removeDevice(params);
}

export type RenameDeviceParams = { devId: string; name: string };

export function renameDevice(params: RenameDeviceParams): Promise<string> {
  return tuya.renameDevice(params);
}

export type GetDataPointStatsParams = {
  devId: string;
  DataPointTypeEnum: 'DAY' | 'WEEK' | 'MONTH';
  number: number; // number of historical data result values, up to 50
  dpId: string;
  startTime: number; // in ms
};

export function getDataPointStat(
  params: GetDataPointStatsParams
): Promise<any> {
  return tuya.getDataPointStat(params);
}
