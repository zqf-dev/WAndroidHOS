/**
 * Banners实体类
 */
import { IState } from './IStatus';

export class HomeModel {
  bannerData: Array<IBannerModel>
  status: number = IState.Loading
}

export class IBannerModel {
  desc?: string = '';
  id?: number = 0;
  title?: string = '';
  imagePath?: string = '';
}

export class Article {
  offset: number = 0
  over: boolean = false
  pageCount: number = 0
  size: number = 0
  total: number = 0
  curPage: number = 1
  datas: Array<IArticle>
}

export class IArticle {
  title: string = '';
  superChapterName: string = ''
  niceDate: string = ''
  niceShareDate: string = ''
  shareUser: string = ''
  adminAdd: boolean
  apkLink: string = ''
  audit: number = 1
  author: string = ''
  canEdit: boolean
  chapterId: number = 0
  chapterName: string = ''
  collect: boolean
  courseId: number = 0
  desc: string = ''
  descMd: string = ''
  envelopePic: string = ''
  fresh: boolean
  host: string = ''
  id: number = 0
  isAdminAdd: boolean
  link: string = ''
  origin: string = ''
  prefix: string = ''
  projectLink: string = ''
  publishTime: number = 0
  realSuperChapterId: number = 0
  selfVisible: number = 0
  shareDate: number = 0
  superChapterId: number = 0
  tags: Array<ITags>
  type: number = 0
  userId: number = 0
  visible: number = 1
  zan: number = 0
}

export class ITags {
  name: string = ''
  url: string = ''
}