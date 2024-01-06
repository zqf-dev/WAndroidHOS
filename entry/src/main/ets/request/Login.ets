import HashMap from '@ohos.util.HashMap';
import { API } from '../http/API';
import { get, post, postForm } from '../http/Request';
import { Response } from '../http/Response';
/**
 * 登录
 */
export function userLogin(params: HashMap<string, Object>): Promise<any> {
  return new Promise((resolve, reject) => {
    postForm(API.login, params).then((data: Response) => {
      if (data.data && data.errorCode === API.SERVER_CODE_SUCCESS) {
        resolve(data.data);
      } else {
        reject(data.errorMsg);
      }
    }).catch((err: Error) => {
      reject($r('app.string.http_error_message'));
    });
  });
}