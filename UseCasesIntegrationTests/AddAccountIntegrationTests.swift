
import XCTest
import Data
import Infra
import Domain


class AddAccountIntegrationTests: XCTestCase {

     func test_add_account() {
         let alamofireAdapter = AlamofireAdapter()
         let url = URL(string: "https://fordevs.herokuapp.com/api/signup")!
         let sut = RemoteAddAccount(url: url, httpClient: alamofireAdapter)
         let addAccountModel = AddAccountModel(name: "Gabriel Oliveira", email: "\(UUID().uuidString)@gmail.com", password: "secret", passwordConfirmation: "secret")
         
         let exp = expectation(description: "waiting")
         sut.add(addAccountModel: addAccountModel) { result in
             
             switch result {
             case .failure: XCTFail("Expect success got \(result) instead")
             case .success(let account):
                 XCTAssertNotNil(account.accessToken)
                
             }
             exp.fulfill()
         }
         wait(for: [exp], timeout: 15)
         
         let exp2 = expectation(description: "waiting")
         sut.add(addAccountModel: addAccountModel) { result in
             
             switch result {
             case .failure(let error) where error == .emailInUse:
                 XCTAssertNotNil(error)
             default:
                 XCTFail("Expect success got \(result) instead")
             }
             exp.fulfill()
         }
         wait(for: [exp2], timeout: 15)
     }

   

}
