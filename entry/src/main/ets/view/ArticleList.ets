import { Article, IArticle } from '../model/HomeEntity';
import { getArticle, } from '../request/Home'
import { Constants } from '../utils/Constants';
import LoadMoreLayout from './LoadMoreLayout';
import NoMoreLayout from './NoMoreLayout';

@Component
export struct ArticleList {
  @State curIndex: number = 0;
  @State list: Article = new Article()
  @State isRefreshing: boolean = false

  aboutToAppear() {
    this.Article()
  }

  Article() {
    getArticle(this.curIndex).then((res: Article) => {
      this.list.datas = res.datas
    })
  }

  @Builder showData() {
    //下拉刷新
    Refresh({ refreshing: this.isRefreshing }) {
      List() {
        ForEach(this.list.datas, (item: IArticle) => {
          ListItem() {
            Flex({ direction: FlexDirection.Column }) {
              //作者+新/置顶/时间
              Flex({ justifyContent: FlexAlign.SpaceBetween, alignItems: ItemAlign.Center }) {
                Flex({ alignItems: ItemAlign.Center }) {
                  //作者
                  Text(item.author ? "作者：" + item.author : "分享者：" + item.shareUser).fontSize(Constants.fs_11)
                  //置顶数据
                  if (item.type === 1) {
                    Text('置顶')
                      .fontColor(Color.Red)
                      .borderRadius(Constants.fs_12)
                      .fontSize(Constants.fs_10)
                      .borderWidth(1)
                      .borderColor(Color.Red)
                      .margin({ left: Constants.fs_10 })
                      .padding({ left: 5, right: 5, top: 3, bottom: 3 })
                  }
                  if (item.fresh) {
                    //是否最新数据
                    Text('新')
                      .fontColor(Color.Red)
                      .fontSize(11)
                      .borderRadius(10)
                      .borderWidth(1)
                      .borderColor(Color.Red)
                      .margin({ left: 10 })
                      .textAlign(TextAlign.Center)
                      .padding({ left: 5, right: 5, top: 3, bottom: 3 })
                  } else {
                    if (item.tags.length > 0) {
                      Text(item.tags[0].name)
                        .fontColor(Color.Green)
                        .fontSize(Constants.fs_10)
                        .borderRadius(Constants.fs_12)
                        .borderWidth(1)
                        .textAlign(TextAlign.Center)
                        .borderColor(Color.Green)
                        .padding({ left: 5, right: 5, top: 3, bottom: 3 })
                        .margin({ left: 10 })
                    }
                  }
                }
                //发布时间
                Text(item.niceDate).fontSize(Constants.fs_11).width(Constants.forth_percent).textAlign(TextAlign.End)
              }
              //title
              Text(item.title).fontSize(18).fontColor(Color.Black).margin({ top: 10 }).fontWeight(700)
              //分类
              Text("分类：" + item.superChapterName + " / " + item.chapterName)
                .margin({ top: 10, bottom: 5 })
                .fontSize(Constants.fs_11)
            }
          }
          .backgroundColor('#FFF')
          .margin({ top: 10 })
          .borderRadius(Constants.BORDER_RADIUS)
        }, (item: IArticle, index?: number) => JSON.stringify(item) + index)

        //加载更多/没有更多数据了
        // ListItem() {
        //   if (this.list.over) {
        //     NoMoreLayout()
        //   } else {
        //     LoadMoreLayout()
        //   }
        // }
      }
      .onTouch((event: TouchEvent) => {
        if (event) {
          if (this.list.over) {

          }
        }
      })
      .width(Constants.Article_LIST_WIDTH)
      .height(Constants.FULL_SIZE)
      .margin({ left: Constants.Article_LIST_MARGIN_LEFT, right: Constants.Article_LIST_MARGIN_RIGHT })
      .backgroundColor('#FFF')
      .divider({
        color: '#E2E2E2',
        strokeWidth: Constants.Article_LIST_DIVIDER_STROKE_WIDTH,
        endMargin: Constants.Article_LIST_MARGIN_RIGHT
      })
      .edgeEffect(EdgeEffect.None)
    }.onStateChange((state: RefreshStatus) => {
      console.info(Constants.TAG, state)
    }).onRefreshing(() => {
      console.info(Constants.TAG, 'onRefreshing')
    })
  }

  build() {
    this.showData()
  }
}