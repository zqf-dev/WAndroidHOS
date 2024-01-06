
import ArrayList from '@ohos.util.ArrayList';
import { API } from '../http/API';
import { get } from '../http/Request';
import { Response } from '../http/Response';
import { INav, ITree } from '../model/ITreeBean';
/**
 * 请求体系数据
 */
export function getTree(): Promise<ITree[]> {
  return new Promise((resolve: Function, reject: Function) => {
    get(API.tree).then((data: Response) => {
      if (data.errorCode === API.SERVER_CODE_SUCCESS) {
        resolve(data.data);
      } else {
        console.log('getTree failed', JSON.stringify(data));
        reject($r('app.string.page_none_msg'));
      }
    }).catch((err: Error) => {
      console.log('getTree failed', JSON.stringify(err));
      reject($r('app.string.http_error_message'));
    });
  });
}

/**
 * 导航数据
 * @returns
 */
export function getNav(): Promise<INav[]> {
  return new Promise((resolve: Function, reject: Function) => {
    get(API.nav).then((data: Response) => {
      if (data.errorCode === API.SERVER_CODE_SUCCESS) {
        resolve(data.data);
      } else {
        console.log('getTree failed', JSON.stringify(data));
        reject($r('app.string.page_none_msg'));
      }
    }).catch((err: Error) => {
      console.log('getTree failed', JSON.stringify(err));
      reject($r('app.string.http_error_message'));
    });
  });
}