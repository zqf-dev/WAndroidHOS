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

export class LMCls {
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
      LMCls.downY = event.touches[0].y;
      LMCls.lastMoveY = event.touches[0].y;
      break;
    case TouchType.Move:
      if ((LMCls.isRefreshing === true) || (LMCls.isLoading === true)) {
        return;
      }
      if (LMCls.isCanLoadMore === true && !list.over) {
        if (LMCls.endIndex === list.datas.length - 1 || LMCls.endIndex === list.datas.length) {
          LMCls.offsetY = event.touches[0].y - LMCls.downY;
          if (Math.abs(LMCls.offsetY) > vp2px(Constants.CUSTOM_LAYOUT_HEIGHT) / 2) {
            LMCls.isCanLoadMore = true;
            LMCls.offsetY = -vp2px(Constants.CUSTOM_LAYOUT_HEIGHT) + LMCls.offsetY * Constants.Y_OFF_SET_COEFFICIENT;
          }
        }
      }
      LMCls.lastMoveY = event.touches[0].y;
      break;
    case TouchType.Cancel:
      break;
    case TouchType.Up:
      if ((LMCls.isRefreshing === true) || (LMCls.isLoading === true)) {
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
    LMCls.offsetY = 0;
  })
  if ((LMCls.isCanLoadMore === true)) {
    closeLoadMore();
  } else {
    closeLoadMore();
  }
}

export function closeLoadMore() {
  LMCls.isCanLoadMore = false;
  LMCls.isLoading = false;
}
