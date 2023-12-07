import { RefreshConst } from './RefreshConst';

export default class RefreshModel {
  pullDownRefreshText: Resource = $r('app.string.pull_down_refresh_text');
  pullDownRefreshImage: Resource = $r('app.media.ic_pull_down_refresh');
  pullDownRefreshHeight: number = RefreshConst.CUSTOM_LAYOUT_HEIGHT;
  isVisiblePullDown: boolean = false;
  pullUpLoadText: Resource = $r('app.string.pull_up_load_text');
  pullUpLoadImage: Resource = $r('app.media.ic_pull_up_load');
  pullUpLoadHeight: number = RefreshConst.CUSTOM_LAYOUT_HEIGHT;
  isVisiblePullUpLoad: boolean = false;
  offsetY: number = 0;
  hasMore: boolean = true;
  startIndex = 0;
  endIndex = 0;
  downY = 0;
  lastMoveY = 0;
  isRefreshing: boolean = false;
  isCanRefresh = false;
  isPullRefreshOperation = false;
  isLoading: boolean = false;
  isCanLoadMore: boolean = false;
}

@Observed
export class RefreshLoadLayoutClass {
  isVisible: boolean;
  imageSrc: Resource;
  textValue: Resource;
  heightValue: number;

  constructor(isVisible: boolean, imageSrc: Resource, textValue: Resource, heightValue: number) {
    this.isVisible = isVisible;
    this.imageSrc = imageSrc;
    this.textValue = textValue;
    this.heightValue = heightValue;
  }
}