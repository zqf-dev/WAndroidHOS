import http from '@ohos.net.http';
import { API, ContentType } from './API';
import { Response } from './Response';

/**
 * get方法
 * @param url： 地址
 * @returns ：返回值
 */
export function get(url: string): Promise<Response> {
  let httpRequest = http.createHttp();
  let responseResult = httpRequest.request(url, {
    method: http.RequestMethod.GET,
    readTimeout: API.HTTP_READ_TIMEOUT,
    header: {
      'Content-Type': ContentType.JSON
    },
    connectTimeout: API.HTTP_READ_TIMEOUT,
    extraData: {}
  });
  let serverData: Response = new Response();
  // Processes the data and returns.
  return responseResult.then((value: http.HttpResponse) => {
    if (value.responseCode === API.HTTP_CODE_200) {
      // Obtains the returned data.
      let result = `${value.result}`;
      let resultJson: Response = JSON.parse(result);
      if (resultJson.errorCode === API.SERVER_CODE_SUCCESS) {
        serverData.data = resultJson.data;
      }
      serverData.errorCode = resultJson.errorCode;
      serverData.errorMsg = resultJson.errorMsg;
    } else {
      serverData.errorMsg = `${$r('app.string.http_error_message')}&${value.responseCode}`;
    }
    return serverData;
  }).catch(() => {
    serverData.errorMsg = $r('app.string.http_error_message');
    return serverData;
  })
}


