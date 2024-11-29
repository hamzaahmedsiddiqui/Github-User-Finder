import XCTest
@testable import Github_User_Finder

final class UserSearchViewModelTests: XCTestCase {
    var viewModel: UserSearchViewModel!
    var service: MockGitHubUserService!
    
    override func setUpWithError() throws  {
        super.setUp()

        service = MockGitHubUserService()
        service.mockUser = TestUtils.loadMockUser() // Load mock user for success case
        viewModel = UserSearchViewModel(userService: service)
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        service = nil  // Ensure that the mock service is also cleaned up
        super.tearDown()
    }

    func testSearch_validUser() {
        // Trigger the search and await the asynchronous task
        viewModel.trigger(.search(username: userExsistSearchtext))
        
        XCTAssertNotNil(viewModel.state.userDetailViewModel)
        XCTAssertEqual(viewModel.state.userTag, "hamzaahmedsiddiqui")
    }
    
    func testSearch_userNotFound() {

        viewModel = UserSearchViewModel(userService: service)
        viewModel.trigger(.search(username: noUserSearchtext))
        
        XCTAssertTrue(viewModel.state.showAlert)
        XCTAssertEqual(viewModel.state.errorMessage, NetworkError.notFound.errorDescription)
    }
    
    // Test fetching a user successfully
    func testFetchUser_Success()  {
        service.shouldThrowError = false
        viewModel.trigger(.search(username: userExsistSearchtext))

        XCTAssertNotNil(viewModel.state.userTag)
        XCTAssertEqual(viewModel.state.userTag, userExsistSearchtext)
    }
    
    // Test handling error while fetching user
    func testFetchUser_Error()  {
        service.shouldThrowError = true
        viewModel.trigger(.search(username: noUserSearchtext))

        XCTAssertTrue(viewModel.state.userTag.isEmpty)
        XCTAssertNotNil(viewModel.state.errorMessage)
        XCTAssertTrue(viewModel.state.showAlert)
    }
    

    func testLoadSearchHistory() {
        viewModel.saveSearchHistory(searchText: userExsistSearchtext)
        viewModel.loadSearchHistory()
        XCTAssertTrue(!viewModel.state.searchHistory.isEmpty)
    }

    func testSaveSearchHistory() {
        viewModel.clearHistory()
        viewModel.saveSearchHistory(searchText: "newuser")
        viewModel.loadSearchHistory()
        XCTAssertEqual(viewModel.state.searchHistory[0], "newuser")
    }

    func testClearHistory() {
        viewModel.saveSearchHistory(searchText: "hamza")
        viewModel.clearHistory()
        viewModel.loadSearchHistory()
        XCTAssertTrue(viewModel.state.searchHistory.isEmpty)
    }

}
