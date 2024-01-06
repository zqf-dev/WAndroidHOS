import { Constants } from '../utils/Constants';
import { NavigationList } from './NavigationList';
import { SquareList } from './SquareList';

@Component
export struct Square {
  @Provide tabSquareArray: string[] = ['体系', '导航']
  @State currentIndex: number = 0;

  @Builder TabBuilder(index: number) {
    Column() {
      Text(this.tabSquareArray[index])
        .height(Constants.FULL_PERCENT)
        .fontSize(this.currentIndex === index ? Constants.SELECT_TEXT_FONT_SIZE : Constants.UN_SELECT_TEXT_FONT_SIZE)
        .fontColor(this.currentIndex === index ? $r('app.color.font_color_white') : $r('app.color.font_color_black'))
    }
    .width(Constants.FULL_PERCENT)
    .backgroundColor($r('app.color.launch_bg_color'))
  }

  build() {
    Tabs() {
      ForEach(this.tabSquareArray, (_: string, index: number) => {
        TabContent() {
          Column() {
            if (this.currentIndex === 0) {
              SquareList({ currentIndex: $currentIndex })
            } else if (this.currentIndex === 1) {
              NavigationList()
            }
          }
        }
        .backgroundColor($r('app.color.font_color_white'))
        .tabBar(this.TabBuilder(index))
      }, (item: string) => JSON.stringify(item));
    }
    .barHeight(Constants.SQUARE_TABS_HEIGHT)
    .barMode(BarMode.Fixed)
    .barWidth(Constants.FULL_PERCENT)
    .onChange((index: number) => {
      console.log("Tag", "====" + index);
      this.currentIndex = index;
    })
  }
}