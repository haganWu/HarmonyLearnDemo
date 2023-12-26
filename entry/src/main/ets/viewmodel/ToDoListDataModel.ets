import CommonConstants from '../common/constants/CommonConstant'
export class ToDoListDataModel {
  private tasks: Array<string> = CommonConstants.TODO_DATA;



  getData():Array<string> {
    return this.tasks;
  }
}

export default new ToDoListDataModel()