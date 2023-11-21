/**
 * 加载更多组件
 */
import { Article } from '../model/HomeEntity';
import { Constants } from '../utils/Constants';

@Component
export default struct LoadMoreLayout {
  build() {
    Row() {
      Image($r('app.media.loading_icon'))
        .width(Constants.RefreshLayout_IMAGE_WIDTH)
        .height(Constants.RefreshLayout_IMAGE_HEIGHT)

      Text('加载中...')
        .margin({
          left: Constants.RefreshLayout_TEXT_MARGIN_LEFT,
          bottom: Constants.RefreshLayout_TEXT_MARGIN_BOTTOM
        })
        .fontSize(Constants.RefreshLayout_TEXT_FONT_SIZE)
        .textAlign(TextAlign.Center)
    }
    .clip(true)
    .width(Constants.FULL_SIZE)
    .justifyContent(FlexAlign.Center)
    .height(Constants.CUSTOM_LAYOUT_HEIGHT)
  }
}

export class MoreCls {
  static isCanLoadMore: boolean = false;
  static downY = 0;
  static lastMoveY = 0;
  static isRefreshing: boolean = false;
  static isLoading: boolean = false;
  static startIndex = 0;
  static endIndex = 0;
  //偏移量Y
  static offsetY: number = 0;
}

/**
 * 触摸事件
 * @param event
 */
export function touchEvent(list: Article, event: TouchEvent) {
  switch (event.type) {
    case TouchType.Down:
      MoreCls.downY = event.touches[0].y;
      MoreCls.lastMoveY = event.touches[0].y;
      break;
    case TouchType.Move:
      if ((MoreCls.isRefreshing === true) || (MoreCls.isLoading === true)) {
        return;
      }
      if (MoreCls.isCanLoadMore === true && !list.over) {
        if (MoreCls.endIndex === list.datas.length - 1 || MoreCls.endIndex === list.datas.length) {
          MoreCls.offsetY = event.touches[0].y - MoreCls.downY;
          if (Math.abs(MoreCls.offsetY) > vp2px(Constants.CUSTOM_LAYOUT_HEIGHT) / 2) {
            MoreCls.isCanLoadMore = true;
            MoreCls.offsetY = -vp2px(Constants.CUSTOM_LAYOUT_HEIGHT) + MoreCls.offsetY * Constants.Y_OFF_SET_COEFFICIENT;
          }
        }
      }
      MoreCls.lastMoveY = event.touches[0].y;
      break;
    case TouchType.Cancel:
      break;
    case TouchType.Up:
      if ((MoreCls.isRefreshing === true) || (MoreCls.isLoading === true)) {
        return;
      }
      touchUpLoadMore()
      break;
    default:
      break;
  }
}

export function touchUpLoadMore() {
  animateTo({
    duration: Constants.ANIMATION_DURATION,
  }, () => {
    MoreCls.offsetY = 0;
  })
  if ((MoreCls.isCanLoadMore === true)) {
    closeLoadMore();
  } else {
    closeLoadMore();
  }
}

export function closeLoadMore() {
  MoreCls.isCanLoadMore = false;
  MoreCls.isLoading = false;
}
