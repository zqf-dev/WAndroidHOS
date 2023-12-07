import { MeListBean } from '../model/MeListBean';

export class Constants {
  static readonly SWIPER_DEFAULT_WIDTH: string = '66%';
  static readonly FULL_PERCENT: string = '100%';
  static readonly HALF_PERCENT: string = '50%';
  static readonly IMAGE_CONTAINER_HEIGHT: string = '42%';
  static readonly FULL_SIZE: string = '100%';
  static readonly ICON_SIZE: string = '40%';
  static readonly BAR_HEIGHT: string = '50';
  static readonly CONTENT_WIDTH_PERCENT: string = '87%';
  static readonly SEARCHBAR_WIDTH: string = '91.1%'
  static readonly IMAGE_HEIGHT_MIN: string = '78%';
  static readonly LIST_HEIGHT: string = '90%';

  //TabItem
  static readonly HOME_TITLE: string = '首页';
  static readonly SQUARE_TITLE: string = '广场';
  static readonly ME_TITLE: string = "我的";
  static readonly OPACITY: number = 0.6;
  static readonly BORDER_WIDTH: number = 0.5;
  static readonly COUNTDOWN: number = 5;

  //圆角的RADIUS
  static readonly BORDER_RADIUS = 12;
  //tab页的宽
  static readonly PAGE_WIDTH = '94.4%';
  //banner的高
  static readonly HEIGHT_BANNER = '27%';
  //动画执行的时间.
  static readonly DURATION_ADS = 200;
  //滚动持续时间
  static readonly SWIPER_TIME = 1500;
  //TAG日志
  static readonly TAG = 'Tag';
  static readonly Article_LIST_WIDTH: string = '93.3%';
  static readonly Article_LIST_MARGIN_LEFT: string = '3.3%';
  static readonly Article_LIST_MARGIN_RIGHT: string = '3.3%';
  static readonly Article_LIST_DIVIDER_STROKE_WIDTH: number = 0.5;
  static readonly ten_percent = '10%'
  static readonly twenty_percent = '20%'
  static readonly twenty_five_percent = '25%'
  static readonly thirty_percent = '30%'
  static readonly forth_percent = '40%'
  static readonly fifth_percent = '50%'
  static readonly fs_5 = 5
  static readonly fs_6 = 6
  static readonly fs_8 = 10
  static readonly fs_10 = 10
  static readonly fs_11 = 11
  static readonly fs_12 = 12
  static readonly fs_16 = 16
  static readonly fs_18 = 18

  /**
   * 刷新部分
   */
  static readonly MeListData: MeListBean[] = [
    { id: 1, name: '我的积分', img: $r('app.media.score') },
    { id: 2, name: '我的分享', img: $r('app.media.share') },
    { id: 3, name: '我的收藏', img: $r('app.media.collection') },
    { id: 4, name: '阅读历史', img: $r('app.media.read_record') },
    { id: 5, name: '关于作者', img: $r('app.media.about') },
    { id: 6, name: '系统设置', img: $r('app.media.system') },
  ]
  // Key-Value键值型的数据处理
  static preferences: any = null
}
