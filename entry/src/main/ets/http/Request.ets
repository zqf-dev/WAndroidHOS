import http from '@ohos.net.http';
import { Constants } from '../utils/Constants';
import { API, ContentType } from './API';
import { Response } from './Response';

/**
 * get方法
 * @param url： 地址
 * @returns ：返回值
 */
export function get(url: string): Promise<Response> {
  let httpRequest = http.createHttp();
  console.log(Constants.TAG, url)
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

/**
 * post json 方法
 * @param url： 地址
 * @returns ：返回值
 */
export function post(url: string, params: Map<string, Object>): Promise<Response> {
  let httpRequest = http.createHttp();
  console.log(Constants.TAG, url)
  let responseResult = httpRequest.request(url, {
    method: http.RequestMethod.GET,
    readTimeout: API.HTTP_READ_TIMEOUT,
    connectTimeout: API.HTTP_READ_TIMEOUT,
    header: {
      'Content-Type': ContentType.JSON
    },
    extraData: JSON.stringify(params)
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

/**
 * post Form 方法
 * @param url： 地址
 * @returns ：返回值
 */
export function postForm(url: string, params: Map<string, Object>): Promise<Response> {
  let httpRequest = http.createHttp();
  let mIter = params.entries()
  let temp = mIter.next().value
  let extraData
  while (temp != undefined) {
    extraData += `${temp[0]}=${temp[1]}&`
    temp = mIter.next().value
  }
  let responseResult = httpRequest.request(url, {
    method: http.RequestMethod.GET,
    readTimeout: API.HTTP_READ_TIMEOUT,
    connectTimeout: API.HTTP_READ_TIMEOUT,
    header: {
      'Content-Type': 'application/x-www-form-urlencoded'
    },
    extraData: extraData.substring(0, extraData.length - 1)
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

