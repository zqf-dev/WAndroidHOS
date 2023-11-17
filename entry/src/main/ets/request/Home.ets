import { API } from '../http/API';
import { get } from '../http/Request';
import { Response } from '../http/Response';
import BannerModel from '../model/BannerModel';

export function getBanner(): Promise<BannerModel[]> {
  return new Promise(async (resolve: Function, reject: Function) => {
    get(API.banner).then((data: Response) => {
      if (data.errorCode === API.SERVER_CODE_SUCCESS) {
        resolve(data.data);
      } else {
        console.log('getNewsList failed', JSON.stringify(data));
        reject($r('app.string.page_none_msg'));
      }
    }).catch((err: Error) => {
      console.log('getNewsList failed', JSON.stringify(err));
      reject($r('app.string.http_error_message'));
    });
  });
}