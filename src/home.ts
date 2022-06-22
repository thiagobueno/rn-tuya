import { NativeModules } from 'react-native';
import { DeviceDps } from './device';

const tuya = NativeModules.TuyaHomeModule;

export type QueryRoomListParams = {
  homeId?: number;
};
export type QueryRoomListResponse = {
  name: string;
  displayOrder: number;
  id: number;
  roomId: number;
}[];

export function queryRoomList(
  params: QueryRoomListParams
): Promise<QueryRoomListResponse> {
  return tuya.queryRoomList(params);
}

export type GetHomeDetailParams = {
  homeId: number;
};
export type DeviceDetailResponse = {
  homeId: number;
  isOnline: boolean;
  productId: string;
  devId: string;
  verSw: string;
  name: string;
  quickOpDps: number[]
  dps: DeviceDps;
  homeDisplayOrder: number;
  roomId: number;
  iconUrl: string;
};
export type GetHomeDetailResponse = {
  deviceList: DeviceDetailResponse[];
  groupList: any[];
  meshList: any[];
  sharedDeviceList: any[];
  sharedGroupList: any[];
};

export function getHomeDetail(
  params: GetHomeDetailParams
): Promise<GetHomeDetailResponse> {
  return tuya.getHomeDetail(params);
}

export type UpdateHomeParams = {
  homeId: number;
  name: string;
  geoName: string;
  lon: number;
  lat: number;
};

export function updateHome(params: UpdateHomeParams): Promise<string> {
  return tuya.updateHome(params);
}

export type DismissHomeParams = {
  homeId: number;
};

export function dismissHome(params: DismissHomeParams): Promise<string> {
  return tuya.dismissHome(params);
}

export type SortRoomsParams = {
  idList: number[];
  homeId: number;
};

export function sortRoom(params: SortRoomsParams): Promise<string> {
  return tuya.sortRoom(params);
}

export function addRoom(params: any): Promise<any> {
  return tuya.addRoom(params);
}

export function removeRoom(params: any): Promise<any> {
  return tuya.removeRoom(params);
}