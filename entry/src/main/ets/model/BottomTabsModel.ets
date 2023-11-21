import { BottomTabsItem } from './BottomTabsItem';

export const BottomTabsList: Array<BottomTabsItem> = [
  {
    icon: $r('app.media.ic_home'),
    iconSelected: $r('app.media.ic_home_selected'),
    text: $r('app.string.bottom_text_home')
  },
  {
    icon: $r('app.media.ic_square'),
    iconSelected: $r('app.media.ic_square_selected'),
    text: $r('app.string.bottom_text_square')
  },
  {
    icon: $r('app.media.ic_me'),
    iconSelected: $r('app.media.ic_me_selected'),
    text: $r('app.string.bottom_text_me')
  }
]