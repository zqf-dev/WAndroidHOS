
export class Response {
  /**
   * Code returned by the network request: success, fail.
   */
  errorCode: number;

  /**
   * Message returned by the network request.
   */
  errorMsg: string | Resource;

  /**
   * Data returned by the network request.
   */
  data: string | Object | ArrayBuffer;

  constructor() {
    this.errorCode = 0;
    this.errorMsg = '';
    this.data = '';
  }
}