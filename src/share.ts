import { NativeModules } from 'react-native';

const tuya = NativeModules.TuyaShareModule;

export type AddShareWithHomeIdParams = {
  homeId: number;
  userAccount: string; // email
  countryCode: string;
  devIds: string[];
};

export function addShareWithHomeId(params: AddShareWithHomeIdParams): Promise<any> {
  return tuya.addShareWithHomeId(params);
}