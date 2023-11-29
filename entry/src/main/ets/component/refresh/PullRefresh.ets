import { Constants } from '../../utils/Constants';
import { RefreshConst, RefreshState } from './RefreshConst';

export function listTouchEvent(event: TouchEvent) {
  switch (event.type) {
    case TouchType.Down:
      RefreshConst.downY = event.touches[0].y;
      RefreshConst.lastMoveY = event.touches[0].y;
      break;
    case TouchType.Move:
      console.log(Constants.TAG, "---" + event)
      if ((RefreshConst.isRefreshing === true) || (RefreshConst.isLoading === true)) {
        return;
      }
      let isDownPull = event.touches[0].y - RefreshConst.lastMoveY > 0;
      if (((isDownPull === true) || (RefreshConst.isPullRefreshOperation === true)) && (RefreshConst.isCanLoadMore === false)) {
        touchMovePullRefresh(event);
      } else {
        // touchMoveLoadMore(event);
      }
      RefreshConst.lastMoveY = event.touches[0].y;
      break;
    case TouchType.Cancel:
      break;
    case TouchType.Up:
      if ((RefreshConst.isRefreshing === true) || (RefreshConst.isLoading === true)) {
        return;
      }
      if ((RefreshConst.isPullRefreshOperation === true)) {
        touchUpPullRefresh();
      } else {
        // touchUpLoadMore(newsModel);
      }
      break;
    default:
      break;
  }
}

export function touchUpPullRefresh() {
  if (RefreshConst.isCanRefresh === true) {
    RefreshConst.offsetY = vp2px(RefreshConst.pullDownRefreshHeight);
    pullRefreshState(RefreshState.Refreshing);
    setTimeout(() => {
      closeRefresh(false)
    }, RefreshConst.DELAY_TIME);
  } else {
    closeRefresh(false);
  }
}

export function closeRefresh(isRefreshSuccess: boolean) {
  setTimeout(() => {
    let delay = RefreshConst.RefreshConstant_DELAY_PULL_DOWN_REFRESH;
    if (RefreshConst.isCanRefresh === true) {
      pullRefreshState(isRefreshSuccess ? RefreshState.Success : RefreshState.Fail);
      delay = RefreshConst.RefreshConstant_DELAY_SHRINK_ANIMATION_TIME;
    }
    animateTo({
      duration: RefreshConst.RefreshConstant_CLOSE_PULL_DOWN_REFRESH_TIME,
      delay: delay,
      onFinish: () => {
        pullRefreshState(RefreshState.DropDown);
        RefreshConst.isVisiblePullDown = false;
        RefreshConst.isPullRefreshOperation = false;
      }
    }, () => {
      RefreshConst.offsetY = 0;
    })
  }, RefreshConst.isCanRefresh ? RefreshConst.DELAY_ANIMATION_DURATION : 0);
}

export function touchMovePullRefresh(event: TouchEvent) {
  if (RefreshConst.startIndex === 0) {
    RefreshConst.isPullRefreshOperation = true;
    let height = vp2px(RefreshConst.pullDownRefreshHeight);
    console.log(Constants.TAG, "height " + height)
    RefreshConst.offsetY = event.touches[0].y - RefreshConst.downY;
    console.log(Constants.TAG, "offsetY " + RefreshConst.offsetY)
    //滑动偏移大于下拉刷新布局高度，并且满足刷新条件。
    if (RefreshConst.offsetY >= height) {
      pullRefreshState(RefreshState.Release);
      RefreshConst.offsetY = height + RefreshConst.offsetY * RefreshConst.Y_OFF_SET_COEFFICIENT;
    } else {
      pullRefreshState(RefreshState.DropDown);
    }
    if (RefreshConst.offsetY < 0) {
      RefreshConst.offsetY = 0;
      RefreshConst.isPullRefreshOperation = false;
    }
  }
}

export function pullRefreshState(state: number) {
  switch (state) {
    case RefreshState.DropDown:
      RefreshConst.pullDownRefreshText = $r('app.string.pull_down_refresh_text');
      RefreshConst.pullDownRefreshImage = $r('app.media.ic_pull_down_refresh');
      RefreshConst.isCanRefresh = false;
      RefreshConst.isRefreshing = false;
      RefreshConst.isVisiblePullDown = true;
      break;
    case RefreshState.Release:
      RefreshConst.pullDownRefreshText = $r('app.string.release_refresh_text');
      RefreshConst.pullDownRefreshImage = $r('app.media.ic_pull_up_refresh');
      RefreshConst.isCanRefresh = true;
      RefreshConst.isRefreshing = false;
      break;
    case RefreshState.Refreshing:
      RefreshConst.offsetY = vp2px(RefreshConst.pullDownRefreshHeight);
      RefreshConst.pullDownRefreshText = $r('app.string.refreshing_text');
      RefreshConst.pullDownRefreshImage = $r('app.media.ic_pull_up_load');
      RefreshConst.isCanRefresh = true;
      RefreshConst.isRefreshing = true;
      break;
    case RefreshState.Success:
      RefreshConst.pullDownRefreshText = $r('app.string.refresh_success_text');
      RefreshConst.pullDownRefreshImage = $r('app.media.ic_succeed_refresh');
      RefreshConst.isCanRefresh = true;
      RefreshConst.isRefreshing = true;
      break;
    case RefreshState.Fail:
      RefreshConst.pullDownRefreshText = $r('app.string.refresh_fail_text');
      RefreshConst.pullDownRefreshImage = $r('app.media.ic_fail_refresh');
      RefreshConst.isCanRefresh = true;
      RefreshConst.isRefreshing = true;
      break;
    default:
      break;
  }
}