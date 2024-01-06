//体系
export class ITree {
  children: Array<ITreeChildren>
  name: string
  id: string
  parentChapterId: number
  courseId: number
  order: number
  type: number
  userControlSetTop: boolean
}

export class ITreeChildren {
  name: string
  id: string
  parentChapterId: number
  courseId: number
  order: number
  type: number
  userControlSetTop: boolean
}

//导航
export class INav {
  articles: Array<INavChildren>
  name: string
  cid: string
}

export class INavChildren {
  title: string
  link: string
}