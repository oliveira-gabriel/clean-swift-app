//
//  PresentationTests.swift
//  PresentationTests
//
//  Created by Gabriel Oliveira on 26/02/22.
//

import XCTest

class SignUpPresenter {
    private let alertView: AlertView
    init (alertView: AlertView){
        self.alertView = alertView
    }
    func signUp(viewModel: SignUpViewModel) {
        if(viewModel.name == nil || viewModel.name!.isEmpty){
           alertView.showMessage(viewModel: AlertViewModel(title: "Falha na validação", message: "O campo Nome é obrigatório."))
        }
        if(viewModel.email == nil || viewModel.email!.isEmpty){
           alertView.showMessage(viewModel: AlertViewModel(title: "Falha na validação", message: "O campo Email é obrigatório."))
        }
        
        if(viewModel.password == nil || viewModel.password!.isEmpty){
           alertView.showMessage(viewModel: AlertViewModel(title: "Falha na validação", message: "O campo Senha é obrigatório."))
        }
        
    }
}

protocol AlertView {
    func showMessage(viewModel: AlertViewModel)
}

struct AlertViewModel: Equatable {
    var title: String
    var message: String
}

struct SignUpViewModel{
    var name: String?
    var email: String?
    var password: String?
    var passwordConfirmation: String?
}

class SignUpPresenterTests: XCTestCase {

    func test_signUp_should_show_error_message_if_name_not_provided() {
        let (sut,alertViewSpy) = makeSut()
        
        let signUpViewModel = SignUpViewModel(email: "any_email@email.com", password: "any_password", passwordConfirmation: "any_password")
        sut.signUp(viewModel: signUpViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na validação", message: "O campo Nome é obrigatório."))
    }
    func test_signUp_should_show_error_message_if_email_not_provided() {
        let (sut,alertViewSpy) = makeSut()
        
        let signUpViewModel = SignUpViewModel(name: "any_name",password: "any_password", passwordConfirmation: "any_password")
        sut.signUp(viewModel: signUpViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na validação", message: "O campo Email é obrigatório."))
    }
    func test_signUp_should_show_error_message_if_password_not_provided() {
        let (sut,alertViewSpy) = makeSut()
        
        let signUpViewModel = SignUpViewModel(name: "any_name",email: "any_email@email.com", passwordConfirmation: "any_password")
        sut.signUp(viewModel: signUpViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na validação", message: "O campo Email é obrigatório."))
    }

}


extension SignUpPresenterTests {
    
    func makeSut() -> (sut: SignUpPresenter, alertViewSpy: AlertViewSpy){
        let alertViewSpy = AlertViewSpy()
        let sut = SignUpPresenter(alertView: alertViewSpy)
        return (sut, alertViewSpy)
    }
    
    class AlertViewSpy: AlertView {
        var viewModel: AlertViewModel?
        func showMessage(viewModel: AlertViewModel) {
            self.viewModel = viewModel
        }
    }
}
