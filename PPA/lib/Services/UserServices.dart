import 'package:googleapis/androidmanagement/v1.dart';
import 'package:ppa/db/Account%20model.dart';
import 'package:ppa/db/Database.dart';
import 'package:ppa/db/passwordmodel.dart';
import 'package:ppa/db/repository.dart';

class UserServices{
  late Repository _repository;
  UserServices(){
    _repository=Repository();
  }

  SaveUser(ModelPass user)async{
    return await _repository.insertData('password', user.passwordMap());
  }

  ReadAllPassword()async{
    return await _repository.readData('password');
  }
  UpdateUser(ModelPass user)async{
    return await _repository.updateData('password', user.passwordMap());
  }
  DeleteUserPass(Userid)async{
    return await _repository.deleteDataById('password', Userid);
  }



  //user account data

  SaveUserAccount(ModelUser user)async{
    return await _repository.insertData('user', user.UserMap());
  }
  ReadAllUser()async{
    return await _repository.readData('user');
  }
  UpdateUserAccount(ModelUser user)async{
    return await _repository.updateData('user', user.UserMap());
  }
  Sigin(String email,String pass)async{
    return await _repository.readDataById('user', email, pass);
  }
  Match(String text)async{
    return await _repository.readDataByQ('user', text);
  }
  AccountData(int text)async{
    return await _repository.readDataAccountById('user', text);
  }

}