import { API } from '../http/API';
import { get } from '../http/Request';
import { Response } from '../http/Response';
import { Article, HomeModel, IBannerModel } from '../model/HomeEntity';
import { Constants } from '../utils/Constants';

/**
 * 请求Banner数据
 * @returns
 */
export function getBanner(): Promise<IBannerModel[]> {
  return new Promise((resolve: Function, reject: Function) => {
    get(API.banner).then((data: Response) => {
      console.log("Tag", "data " + data)
      if (data.data && data.errorCode === API.SERVER_CODE_SUCCESS) {
        resolve(data.data);
      } else {
        console.log('getBannerList failed', JSON.stringify(data));
        reject($r('app.string.page_none_msg'));
      }
    }).catch((err: Error) => {
      console.log('getBannerList failed', JSON.stringify(err));
      reject($r('app.string.http_error_message'));
    });
  });
}

/**
 * 请求文章数据
 */
export function getArticle(page: number): Promise<Article> {
  return new Promise((resolve: Function, reject: Function) => {
    get(API.article + page + '/json').then((data: Response) => {
      if (data.errorCode === API.SERVER_CODE_SUCCESS) {
        resolve(data.data);
      } else {
        console.log('request failed', JSON.stringify(data));
        reject($r('app.string.page_none_msg'));
      }
    }).catch((err: Error) => {
      console.log('request failed', JSON.stringify(err));
      reject($r('app.string.http_error_message'));
    });
  });
}