import Prompt from '@system.prompt';
import { IState } from '../model/IStatus';
import { ITree, ITreeChildren } from '../model/ITreeBean';
import { getTree } from '../request/SquareReq';
import { Constants } from '../utils/Constants';

@Component
export struct SquareList {
  @Watch('category') @Link currentIndex: number;
  @State list: ITree[] = new Array()
  @State status: IState = IState.Loading
  scroll: Scroller = new Scroller()

  category() {
    if (this.currentIndex === 0) {
      getTree().then((data: ITree[]) => {
        this.list = [...data];
        this.status = IState.Success
      }).catch((err: string | Resource) => {
        console.log('getTree failed', err);
      })
    }
  }

  aboutToAppear() {
    this.category();
  }

  @Builder LoadingLayout() {
    Text('加载中...').width('100%').height('100%').textAlign(TextAlign.Center)
  }

  @Builder showTree() {
    Scroll(this.scroll) {
      Column() {
        ForEach(this.list, (item: ITree, index) => {
          Column() {
            Text(item.name)
              .width(Constants.FULL_PERCENT)
              .textAlign(TextAlign.Start)
              .margin(10)
              .fontSize(20)
            Flex({
              wrap: FlexWrap.Wrap
            }) {
              ForEach(item.children, (itemChild: ITreeChildren, item) => {
                Button(itemChild.name)
                  .backgroundColor('#EEEEEE')
                  .borderRadius(30)
                  .fontColor(Color.Black)
                  .margin(5)
                  .padding({ left: 8, right: 8 })
                  .onClick(() => {
                    Prompt.showToast({ message: '点击了' + itemChild.name })
                  })
              }, (item: ITreeChildren, index?: number) => JSON.stringify(item) + index)
            }
          }.padding({ left: 10, right: 10 })
        }, (item: ITree, index?: number) => JSON.stringify(item) + index)
      }
      .width(Constants.FULL_PERCENT)
    }
    .scrollable(ScrollDirection.Vertical)
    .edgeEffect(EdgeEffect.Spring)
  }

  build() {
    if (this.status === IState.Loading) {
      this.LoadingLayout()
    } else {
      this.showTree()
    }
  }
}