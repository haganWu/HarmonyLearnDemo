import router from '@ohos.router';

@Entry
@Component
struct SecondPage {
  @State message: string = 'Hello World';
  @State src: string = router.getParams()?.['src'];

  build() {
    Row() {
      Column() {
        Text(this.src)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
    }
    .height('100%')
  }
}