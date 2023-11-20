export class API {
  //服务器地址
  static readonly Url = 'https://www.wanandroid.com'
  //广告页
  static readonly banner = API.Url + '/banner/json'
  //文章
  static readonly article = API.Url + '/article/list/'
  //读取超时
  static readonly HTTP_READ_TIMEOUT = 10 * 1000
  /**
   * Http请求成功的code.
   */
  static readonly HTTP_CODE_200: number = 200;
  /**
   * wanAndroid 接口返回的成功的code.
   */
  static readonly SERVER_CODE_SUCCESS: number = 0;
}

export const enum ContentType {
  JSON = 'application/json'
}