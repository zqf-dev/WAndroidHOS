export class RefreshConst {
  static startIndex = 0;
  static endIndex = 0;
  static offsetY = 0;
  static downY = 0;
  static lastMoveY = 0;
  static isVisiblePullUpLoad: boolean = false;
  static isVisiblePullDown: boolean = false;
  static isCanRefresh: boolean = false;
  static isRefreshing: boolean = false;
  static isLoading: boolean = false;
  static isPullRefreshOperation: boolean = false;
  static isCanLoadMore: boolean = false;
  static CUSTOM_LAYOUT_HEIGHT: number = 70;
  static pullDownRefreshText: Resource = $r('app.string.pull_down_refresh_text');
  static pullDownRefreshImage: Resource = $r('app.media.ic_pull_down_refresh');
  static pullDownRefreshHeight: number = 70;
  static readonly RefreshLayout_MARGIN_LEFT: string = '40%';
  static readonly RefreshLayout_TEXT_MARGIN_BOTTOM: number = 1;
  static readonly RefreshLayout_TEXT_MARGIN_LEFT: number = 7;
  static readonly RefreshLayout_TEXT_FONT_SIZE: number = 17;
  static readonly RefreshLayout_IMAGE_WIDTH: number = 18;
  static readonly RefreshLayout_IMAGE_HEIGHT: number = 18;
  static readonly Y_OFF_SET_COEFFICIENT: number = 0.1;
  static readonly ANIMATION_DURATION: number = 2000;
  static readonly DELAY_ANIMATION_DURATION: number = 300;
  static readonly DELAY_TIME: number = 1000;
  static readonly RefreshConstant_DELAY_PULL_DOWN_REFRESH: number = 50;
  static readonly RefreshConstant_CLOSE_PULL_DOWN_REFRESH_TIME: number = 150;
  static readonly RefreshConstant_DELAY_SHRINK_ANIMATION_TIME: number = 500;
  static readonly LIST_OFFSET_UNIT: string = 'px';
}

export const enum RefreshState {
  DropDown = 0,
  Release = 1,
  Refreshing = 2,
  Success = 3,
  Fail = 4
}