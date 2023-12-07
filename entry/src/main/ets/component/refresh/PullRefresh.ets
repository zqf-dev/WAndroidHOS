import promptAction from '@ohos.promptAction';
import { Article } from '../../model/HomeEntity';
import { getArticle } from '../../request/Home';
import { Constants } from '../../utils/Constants';
import { RefreshConst, RefreshState } from './RefreshConst';
import RefreshModel from './RefreshModel';

export function listTouchEvent(event: TouchEvent, list: Article, refresh: RefreshModel) {
  switch (event.type) {
    case TouchType.Down:
      refresh.downY = event.touches[0].y;
      refresh.lastMoveY = event.touches[0].y;
      break;
    case TouchType.Move:
      if ((refresh.isRefreshing === true) || (refresh.isLoading === true)) {
        return;
      }
      let isDownPull = event.touches[0].y - refresh.lastMoveY > 0;
      if (((isDownPull === true) || (refresh.isPullRefreshOperation === true)) && (refresh.isCanLoadMore === false)) {
        touchMovePullRefresh(event, refresh);
      } else {
        touchMoveLoadMore(refresh, list, event);
      }
      refresh.lastMoveY = event.touches[0].y;
      break;
    case TouchType.Cancel:
      break;
    case TouchType.Up:
      if ((refresh.isRefreshing === true) || (refresh.isLoading === true)) {
        return;
      }
      if ((refresh.isPullRefreshOperation === true)) {
        touchUpPullRefresh(refresh);
      } else {
        touchUpLoadMore(refresh);
      }
      break;
    default:
      break;
  }
}

export function touchUpPullRefresh(refresh: RefreshModel) {
  if (refresh.isCanRefresh === true) {
    refresh.offsetY = vp2px(refresh.pullDownRefreshHeight);
    pullRefreshState(RefreshState.Refreshing, refresh);
    setTimeout(() => {
      let self: RefreshModel = refresh;
      closeRefresh(true, self);
    }, RefreshConst.DELAY_TIME);
  } else {
    closeRefresh(false, refresh);
  }
}

export function closeRefresh(isRefreshSuccess: boolean, refresh: RefreshModel) {
  let self = refresh;
  setTimeout(() => {
    let delay = RefreshConst.RefreshConstant_DELAY_PULL_DOWN_REFRESH;
    if (self.isCanRefresh === true) {
      pullRefreshState(isRefreshSuccess ? RefreshState.Success : RefreshState.Fail, refresh);
      delay = RefreshConst.RefreshConstant_DELAY_SHRINK_ANIMATION_TIME;
    }
    animateTo({
      duration: RefreshConst.RefreshConstant_CLOSE_PULL_DOWN_REFRESH_TIME,
      delay: delay,
      onFinish: () => {
        pullRefreshState(RefreshState.DropDown, refresh);
        self.isVisiblePullDown = false;
        self.isPullRefreshOperation = false;
      }
    }, () => {
      self.offsetY = 0;
    })
  }, self.isCanRefresh ? RefreshConst.DELAY_ANIMATION_DURATION : 0);
}

export function touchMovePullRefresh(event: TouchEvent, refresh: RefreshModel) {
  if (refresh.startIndex === 0) {
    refresh.isPullRefreshOperation = true;
    let height = vp2px(refresh.pullDownRefreshHeight);
    refresh.offsetY = event.touches[0].y - refresh.downY;
    //滑动偏移大于下拉刷新布局高度，并且满足刷新条件。
    if (refresh.offsetY >= height) {
      pullRefreshState(RefreshState.Release, refresh);
      refresh.offsetY = height + refresh.offsetY * RefreshConst.Y_OFF_SET_COEFFICIENT;
    } else {
      pullRefreshState(RefreshState.DropDown, refresh);
    }
    if (refresh.offsetY < 0) {
      refresh.offsetY = 0;
      refresh.isPullRefreshOperation = false;
    }
  }
}

export function touchMoveLoadMore(refresh: RefreshModel, list: Article, event: TouchEvent) {
  if (refresh.endIndex === list.datas.length - 1 || refresh.endIndex === list.datas.length) {
    refresh.offsetY = event.touches[0].y - refresh.downY;
    if (Math.abs(refresh.offsetY) > vp2px(refresh.pullUpLoadHeight) / 2) {
      refresh.isCanLoadMore = true;
      refresh.isVisiblePullUpLoad = true;
      refresh.offsetY = -vp2px(refresh.pullUpLoadHeight) + refresh.offsetY * RefreshConst.Y_OFF_SET_COEFFICIENT;
    }
  }
}

export function touchUpLoadMore(refresh: RefreshModel) {
  let self: RefreshModel = refresh;
  animateTo({
    duration: RefreshConst.ANIMATION_DURATION,
  }, () => {
    self.offsetY = 0;
  })
  if ((self.isCanLoadMore === true) && (self.hasMore === true)) {
    self.isLoading = true;
    setTimeout(() => {
      //默认1s后关闭加载更多
      self.hasMore = true;
      closeLoadMore(refresh);
    }, RefreshConst.DELAY_TIME);
  } else {
    closeLoadMore(self);
  }
}

export function closeLoadMore(refresh: RefreshModel) {
  refresh.isCanLoadMore = false;
  refresh.isLoading = false;
  refresh.isVisiblePullUpLoad = false;
}

export function pullRefreshState(state: number, refresh: RefreshModel) {
  switch (state) {
    case RefreshState.DropDown:
      refresh.pullDownRefreshText = $r('app.string.pull_down_refresh_text');
      refresh.pullDownRefreshImage = $r('app.media.ic_pull_down_refresh');
      refresh.isCanRefresh = false;
      refresh.isRefreshing = false;
      refresh.isVisiblePullDown = true;
      break;
    case RefreshState.Release:
      refresh.pullDownRefreshText = $r('app.string.release_refresh_text');
      refresh.pullDownRefreshImage = $r('app.media.ic_pull_up_refresh');
      refresh.isCanRefresh = true;
      refresh.isRefreshing = false;
      break;
    case RefreshState.Refreshing:
      refresh.offsetY = vp2px(refresh.pullDownRefreshHeight);
      refresh.pullDownRefreshText = $r('app.string.refreshing_text');
      refresh.pullDownRefreshImage = $r('app.media.ic_pull_up_load');
      refresh.isCanRefresh = true;
      refresh.isRefreshing = true;
      break;
    case RefreshState.Success:
      refresh.pullDownRefreshText = $r('app.string.refresh_success_text');
      refresh.pullDownRefreshImage = $r('app.media.ic_succeed_refresh');
      refresh.isCanRefresh = true;
      refresh.isRefreshing = true;
      break;
    case RefreshState.Fail:
      refresh.pullDownRefreshText = $r('app.string.refresh_fail_text');
      refresh.pullDownRefreshImage = $r('app.media.ic_fail_refresh');
      refresh.isCanRefresh = true;
      refresh.isRefreshing = true;
      break;
    default:
      break;
  }
}