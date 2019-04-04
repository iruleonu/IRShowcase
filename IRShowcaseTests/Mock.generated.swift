// Generated using Sourcery 0.16.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


//swiftlint:disable identifier_name
//swiftlint:disable function_body_length
//swiftlint:disable force_cast
//swiftlint:disable vertical_whitespace

#if MockyCustom
import SwiftyMocky
import ReactiveSwift
import Result
@testable import IRShowcase

    public final class MockyAssertion {
        public static var handler: ((Bool, String, StaticString, UInt) -> Void)?
    }

    func MockyAssert(_ expression: @autoclosure () -> Bool, _ message: @autoclosure () -> String = "Verification failed", file: StaticString = #file, line: UInt = #line) {
        guard let handler = MockyAssertion.handler else {
            assert(expression, message, file: file, line: line)
            return
        }

        handler(expression(), message(), file, line)
    }
#elseif Mocky
import SwiftyMocky
import XCTest
import ReactiveSwift
import Result
@testable import IRShowcase

    func MockyAssert(_ expression: @autoclosure () -> Bool, _ message: @autoclosure () -> String = "Verification failed", file: StaticString = #file, line: UInt = #line) {
        XCTAssert(expression(), message(), file: file, line: line)
    }
#else
import Sourcery
import SourceryRuntime
#endif



// MARK: - APIService
class APIServiceMock: APIService, Mock {
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    typealias PropertyStub = Given
    typealias MethodStub = Given
    typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    var serverConfig: ServerConfigProtocol {
		get {	invocations.append(.p_serverConfig_get); return __p_serverConfig ?? givenGetterValue(.p_serverConfig_get, "APIServiceMock - stub value for serverConfig was not defined") }
		@available(*, deprecated, message: "Using setters on readonly variables is deprecated, and will be removed in 3.1. Use Given to define stubbed property return value.")
		set {	__p_serverConfig = newValue }
	}
	private var __p_serverConfig: (ServerConfigProtocol)?

    var apiBaseUrl: URL {
		get {	invocations.append(.p_apiBaseUrl_get); return __p_apiBaseUrl ?? givenGetterValue(.p_apiBaseUrl_get, "APIServiceMock - stub value for apiBaseUrl was not defined") }
		@available(*, deprecated, message: "Using setters on readonly variables is deprecated, and will be removed in 3.1. Use Given to define stubbed property return value.")
		set {	__p_apiBaseUrl = newValue }
	}
	private var __p_apiBaseUrl: (URL)?





    required init(serverConfig: ServerConfigProtocol) { }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        addInvocation(.m_application__applicationdidFinishLaunchingWithOptions_launchOptions(Parameter<UIApplication>.value(`application`), Parameter<[UIApplication.LaunchOptionsKey: Any]?>.value(`launchOptions`)))
		let perform = methodPerformValue(.m_application__applicationdidFinishLaunchingWithOptions_launchOptions(Parameter<UIApplication>.value(`application`), Parameter<[UIApplication.LaunchOptionsKey: Any]?>.value(`launchOptions`))) as? (UIApplication, [UIApplication.LaunchOptionsKey: Any]?) -> Void
		perform?(`application`, `launchOptions`)
		var __value: Bool
		do {
		    __value = try methodReturnValue(.m_application__applicationdidFinishLaunchingWithOptions_launchOptions(Parameter<UIApplication>.value(`application`), Parameter<[UIApplication.LaunchOptionsKey: Any]?>.value(`launchOptions`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?). Use given")
			Failure("Stub return value not specified for application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?). Use given")
		}
		return __value
    }

    func buildUrlRequest(resource: Resource) -> URLRequest {
        addInvocation(.m_buildUrlRequest__resource_resource(Parameter<Resource>.value(`resource`)))
		let perform = methodPerformValue(.m_buildUrlRequest__resource_resource(Parameter<Resource>.value(`resource`))) as? (Resource) -> Void
		perform?(`resource`)
		var __value: URLRequest
		do {
		    __value = try methodReturnValue(.m_buildUrlRequest__resource_resource(Parameter<Resource>.value(`resource`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for buildUrlRequest(resource: Resource). Use given")
			Failure("Stub return value not specified for buildUrlRequest(resource: Resource). Use given")
		}
		return __value
    }

    func fetchData(request: URLRequest) -> SignalProducer<(Data, URLResponse), DataProviderError> {
        addInvocation(.m_fetchData__request_request(Parameter<URLRequest>.value(`request`)))
		let perform = methodPerformValue(.m_fetchData__request_request(Parameter<URLRequest>.value(`request`))) as? (URLRequest) -> Void
		perform?(`request`)
		var __value: SignalProducer<(Data, URLResponse), DataProviderError>
		do {
		    __value = try methodReturnValue(.m_fetchData__request_request(Parameter<URLRequest>.value(`request`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for fetchData(request: URLRequest). Use given")
			Failure("Stub return value not specified for fetchData(request: URLRequest). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_application__applicationdidFinishLaunchingWithOptions_launchOptions(Parameter<UIApplication>, Parameter<[UIApplication.LaunchOptionsKey: Any]?>)
        case m_buildUrlRequest__resource_resource(Parameter<Resource>)
        case m_fetchData__request_request(Parameter<URLRequest>)
        case p_serverConfig_get
        case p_apiBaseUrl_get

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
            case (.m_application__applicationdidFinishLaunchingWithOptions_launchOptions(let lhsApplication, let lhsLaunchoptions), .m_application__applicationdidFinishLaunchingWithOptions_launchOptions(let rhsApplication, let rhsLaunchoptions)):
                guard Parameter.compare(lhs: lhsApplication, rhs: rhsApplication, with: matcher) else { return false } 
                guard Parameter.compare(lhs: lhsLaunchoptions, rhs: rhsLaunchoptions, with: matcher) else { return false } 
                return true 
            case (.m_buildUrlRequest__resource_resource(let lhsResource), .m_buildUrlRequest__resource_resource(let rhsResource)):
                guard Parameter.compare(lhs: lhsResource, rhs: rhsResource, with: matcher) else { return false } 
                return true 
            case (.m_fetchData__request_request(let lhsRequest), .m_fetchData__request_request(let rhsRequest)):
                guard Parameter.compare(lhs: lhsRequest, rhs: rhsRequest, with: matcher) else { return false } 
                return true 
            case (.p_serverConfig_get,.p_serverConfig_get): return true
            case (.p_apiBaseUrl_get,.p_apiBaseUrl_get): return true
            default: return false
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_application__applicationdidFinishLaunchingWithOptions_launchOptions(p0, p1): return p0.intValue + p1.intValue
            case let .m_buildUrlRequest__resource_resource(p0): return p0.intValue
            case let .m_fetchData__request_request(p0): return p0.intValue
            case .p_serverConfig_get: return 0
            case .p_apiBaseUrl_get: return 0
            }
        }
    }

    class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [SwiftyMocky.Product]) {
            self.method = method
            super.init(products)
        }

        static func serverConfig(getter defaultValue: ServerConfigProtocol...) -> PropertyStub {
            return Given(method: .p_serverConfig_get, products: defaultValue.map({ SwiftyMocky.Product.return($0) }))
        }
        static func apiBaseUrl(getter defaultValue: URL...) -> PropertyStub {
            return Given(method: .p_apiBaseUrl_get, products: defaultValue.map({ SwiftyMocky.Product.return($0) }))
        }

        static func application(_ application: Parameter<UIApplication>, didFinishLaunchingWithOptions launchOptions: Parameter<[UIApplication.LaunchOptionsKey: Any]?>, willReturn: Bool...) -> MethodStub {
            return Given(method: .m_application__applicationdidFinishLaunchingWithOptions_launchOptions(`application`, `launchOptions`), products: willReturn.map({ SwiftyMocky.Product.return($0) }))
        }
        @available(*, deprecated, message: "This constructor is deprecated, and will be removed in v3.1 Possible fix:  remove `application` label")
		static func application(application: Parameter<UIApplication>, didFinishLaunchingWithOptions launchOptions: Parameter<[UIApplication.LaunchOptionsKey: Any]?>, willReturn: Bool...) -> MethodStub {
            return Given(method: .m_application__applicationdidFinishLaunchingWithOptions_launchOptions(`application`, `launchOptions`), products: willReturn.map({ SwiftyMocky.Product.return($0) }))
        }
        static func buildUrlRequest(resource: Parameter<Resource>, willReturn: URLRequest...) -> MethodStub {
            return Given(method: .m_buildUrlRequest__resource_resource(`resource`), products: willReturn.map({ SwiftyMocky.Product.return($0) }))
        }
        static func fetchData(request: Parameter<URLRequest>, willReturn: SignalProducer<(Data, URLResponse), DataProviderError>...) -> MethodStub {
            return Given(method: .m_fetchData__request_request(`request`), products: willReturn.map({ SwiftyMocky.Product.return($0) }))
        }
        static func application(_ application: Parameter<UIApplication>, didFinishLaunchingWithOptions launchOptions: Parameter<[UIApplication.LaunchOptionsKey: Any]?>, willProduce: (Stubber<Bool>) -> Void) -> MethodStub {
            let willReturn: [Bool] = []
			let given: Given = { return Given(method: .m_application__applicationdidFinishLaunchingWithOptions_launchOptions(`application`, `launchOptions`), products: willReturn.map({ SwiftyMocky.Product.return($0) })) }()
			let stubber = given.stub(for: (Bool).self)
			willProduce(stubber)
			return given
        }
        static func buildUrlRequest(resource: Parameter<Resource>, willProduce: (Stubber<URLRequest>) -> Void) -> MethodStub {
            let willReturn: [URLRequest] = []
			let given: Given = { return Given(method: .m_buildUrlRequest__resource_resource(`resource`), products: willReturn.map({ SwiftyMocky.Product.return($0) })) }()
			let stubber = given.stub(for: (URLRequest).self)
			willProduce(stubber)
			return given
        }
        static func fetchData(request: Parameter<URLRequest>, willProduce: (Stubber<SignalProducer<(Data, URLResponse), DataProviderError>>) -> Void) -> MethodStub {
            let willReturn: [SignalProducer<(Data, URLResponse), DataProviderError>] = []
			let given: Given = { return Given(method: .m_fetchData__request_request(`request`), products: willReturn.map({ SwiftyMocky.Product.return($0) })) }()
			let stubber = given.stub(for: (SignalProducer<(Data, URLResponse), DataProviderError>).self)
			willProduce(stubber)
			return given
        }
    }

    struct Verify {
        fileprivate var method: MethodType

        static func application(_ application: Parameter<UIApplication>, didFinishLaunchingWithOptions launchOptions: Parameter<[UIApplication.LaunchOptionsKey: Any]?>) -> Verify { return Verify(method: .m_application__applicationdidFinishLaunchingWithOptions_launchOptions(`application`, `launchOptions`))}
        @available(*, deprecated, message: "This constructor is deprecated, and will be removed in v3.1 Possible fix:  remove `application` label")
		static func application(application: Parameter<UIApplication>, didFinishLaunchingWithOptions launchOptions: Parameter<[UIApplication.LaunchOptionsKey: Any]?>) -> Verify { return Verify(method: .m_application__applicationdidFinishLaunchingWithOptions_launchOptions(`application`, `launchOptions`))}
        static func buildUrlRequest(resource: Parameter<Resource>) -> Verify { return Verify(method: .m_buildUrlRequest__resource_resource(`resource`))}
        static func fetchData(request: Parameter<URLRequest>) -> Verify { return Verify(method: .m_fetchData__request_request(`request`))}
        static var serverConfig: Verify { return Verify(method: .p_serverConfig_get) }
        static var apiBaseUrl: Verify { return Verify(method: .p_apiBaseUrl_get) }
    }

    struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        static func application(_ application: Parameter<UIApplication>, didFinishLaunchingWithOptions launchOptions: Parameter<[UIApplication.LaunchOptionsKey: Any]?>, perform: @escaping (UIApplication, [UIApplication.LaunchOptionsKey: Any]?) -> Void) -> Perform {
            return Perform(method: .m_application__applicationdidFinishLaunchingWithOptions_launchOptions(`application`, `launchOptions`), performs: perform)
        }
        @available(*, deprecated, message: "This constructor is deprecated, and will be removed in v3.1 Possible fix:  remove `application` label")
		static func application(application: Parameter<UIApplication>, didFinishLaunchingWithOptions launchOptions: Parameter<[UIApplication.LaunchOptionsKey: Any]?>, perform: @escaping (UIApplication, [UIApplication.LaunchOptionsKey: Any]?) -> Void) -> Perform {
            return Perform(method: .m_application__applicationdidFinishLaunchingWithOptions_launchOptions(`application`, `launchOptions`), performs: perform)
        }
        static func buildUrlRequest(resource: Parameter<Resource>, perform: @escaping (Resource) -> Void) -> Perform {
            return Perform(method: .m_buildUrlRequest__resource_resource(`resource`), performs: perform)
        }
        static func fetchData(request: Parameter<URLRequest>, perform: @escaping (URLRequest) -> Void) -> Perform {
            return Perform(method: .m_fetchData__request_request(`request`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let invocations = matchingCalls(method.method)
        MockyAssert(count.matches(invocations.count), "Expeced: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }
    private func methodReturnValue(_ method: MethodType) throws -> SwiftyMocky.Product {
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleMissingStubError(message: message, file: file, line: line)
        #endif
    }
}

// MARK: - ConnectivityService
class ConnectivityServiceMock: ConnectivityService, Mock {
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    typealias PropertyStub = Given
    typealias MethodStub = Given
    typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    var status: MutableProperty<ConnectivityServiceStatus> {
		get {	invocations.append(.p_status_get); return __p_status ?? givenGetterValue(.p_status_get, "ConnectivityServiceMock - stub value for status was not defined") }
		@available(*, deprecated, message: "Using setters on readonly variables is deprecated, and will be removed in 3.1. Use Given to define stubbed property return value.")
		set {	__p_status = newValue }
	}
	private var __p_status: (MutableProperty<ConnectivityServiceStatus>)?

    var isReachableProperty: MutableProperty<Bool> {
		get {	invocations.append(.p_isReachableProperty_get); return __p_isReachableProperty ?? givenGetterValue(.p_isReachableProperty_get, "ConnectivityServiceMock - stub value for isReachableProperty was not defined") }
		@available(*, deprecated, message: "Using setters on readonly variables is deprecated, and will be removed in 3.1. Use Given to define stubbed property return value.")
		set {	__p_isReachableProperty = newValue }
	}
	private var __p_isReachableProperty: (MutableProperty<Bool>)?





    func performSingleConnectivityCheck() -> SignalProducer<ConnectivityServiceStatus, NoError> {
        addInvocation(.m_performSingleConnectivityCheck)
		let perform = methodPerformValue(.m_performSingleConnectivityCheck) as? () -> Void
		perform?()
		var __value: SignalProducer<ConnectivityServiceStatus, NoError>
		do {
		    __value = try methodReturnValue(.m_performSingleConnectivityCheck).casted()
		} catch {
			onFatalFailure("Stub return value not specified for performSingleConnectivityCheck(). Use given")
			Failure("Stub return value not specified for performSingleConnectivityCheck(). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_performSingleConnectivityCheck
        case p_status_get
        case p_isReachableProperty_get

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
            case (.m_performSingleConnectivityCheck, .m_performSingleConnectivityCheck):
                return true 
            case (.p_status_get,.p_status_get): return true
            case (.p_isReachableProperty_get,.p_isReachableProperty_get): return true
            default: return false
            }
        }

        func intValue() -> Int {
            switch self {
            case .m_performSingleConnectivityCheck: return 0
            case .p_status_get: return 0
            case .p_isReachableProperty_get: return 0
            }
        }
    }

    class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [SwiftyMocky.Product]) {
            self.method = method
            super.init(products)
        }

        static func status(getter defaultValue: MutableProperty<ConnectivityServiceStatus>...) -> PropertyStub {
            return Given(method: .p_status_get, products: defaultValue.map({ SwiftyMocky.Product.return($0) }))
        }
        static func isReachableProperty(getter defaultValue: MutableProperty<Bool>...) -> PropertyStub {
            return Given(method: .p_isReachableProperty_get, products: defaultValue.map({ SwiftyMocky.Product.return($0) }))
        }

        static func performSingleConnectivityCheck(willReturn: SignalProducer<ConnectivityServiceStatus, NoError>...) -> MethodStub {
            return Given(method: .m_performSingleConnectivityCheck, products: willReturn.map({ SwiftyMocky.Product.return($0) }))
        }
        static func performSingleConnectivityCheck(willProduce: (Stubber<SignalProducer<ConnectivityServiceStatus, NoError>>) -> Void) -> MethodStub {
            let willReturn: [SignalProducer<ConnectivityServiceStatus, NoError>] = []
			let given: Given = { return Given(method: .m_performSingleConnectivityCheck, products: willReturn.map({ SwiftyMocky.Product.return($0) })) }()
			let stubber = given.stub(for: (SignalProducer<ConnectivityServiceStatus, NoError>).self)
			willProduce(stubber)
			return given
        }
    }

    struct Verify {
        fileprivate var method: MethodType

        static func performSingleConnectivityCheck() -> Verify { return Verify(method: .m_performSingleConnectivityCheck)}
        static var status: Verify { return Verify(method: .p_status_get) }
        static var isReachableProperty: Verify { return Verify(method: .p_isReachableProperty_get) }
    }

    struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        static func performSingleConnectivityCheck(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_performSingleConnectivityCheck, performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let invocations = matchingCalls(method.method)
        MockyAssert(count.matches(invocations.count), "Expeced: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }
    private func methodReturnValue(_ method: MethodType) throws -> SwiftyMocky.Product {
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleMissingStubError(message: message, file: file, line: line)
        #endif
    }
}

// MARK: - PersistenceLayer
class PersistenceLayerMock: PersistenceLayer, Mock {
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    typealias PropertyStub = Given
    typealias MethodStub = Given
    typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }





    func fetchResource<T>(_ resource: Resource) -> SignalProducer<T, PersistenceLayerError> {
        addInvocation(.m_fetchResource__resource(Parameter<Resource>.value(`resource`)))
		let perform = methodPerformValue(.m_fetchResource__resource(Parameter<Resource>.value(`resource`))) as? (Resource) -> Void
		perform?(`resource`)
		var __value: SignalProducer<T, PersistenceLayerError>
		do {
		    __value = try methodReturnValue(.m_fetchResource__resource(Parameter<Resource>.value(`resource`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for fetchResource<T>(_ resource: Resource). Use given")
			Failure("Stub return value not specified for fetchResource<T>(_ resource: Resource). Use given")
		}
		return __value
    }

    func removeResource(_ resource: Resource) -> SignalProducer<Bool, PersistenceLayerError> {
        addInvocation(.m_removeResource__resource(Parameter<Resource>.value(`resource`)))
		let perform = methodPerformValue(.m_removeResource__resource(Parameter<Resource>.value(`resource`))) as? (Resource) -> Void
		perform?(`resource`)
		var __value: SignalProducer<Bool, PersistenceLayerError>
		do {
		    __value = try methodReturnValue(.m_removeResource__resource(Parameter<Resource>.value(`resource`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for removeResource(_ resource: Resource). Use given")
			Failure("Stub return value not specified for removeResource(_ resource: Resource). Use given")
		}
		return __value
    }

    func persistObjects<T>(_ objects: T, saveCompletion: @escaping PersistenceSaveCompletion) {
        addInvocation(.m_persistObjects__objectssaveCompletion_saveCompletion(Parameter<T>.value(`objects`).wrapAsGeneric(), Parameter<PersistenceSaveCompletion>.any))
		let perform = methodPerformValue(.m_persistObjects__objectssaveCompletion_saveCompletion(Parameter<T>.value(`objects`).wrapAsGeneric(), Parameter<PersistenceSaveCompletion>.any)) as? (T, @escaping PersistenceSaveCompletion) -> Void
		perform?(`objects`, `saveCompletion`)
    }


    fileprivate enum MethodType {
        case m_fetchResource__resource(Parameter<Resource>)
        case m_removeResource__resource(Parameter<Resource>)
        case m_persistObjects__objectssaveCompletion_saveCompletion(Parameter<GenericAttribute>, Parameter<PersistenceSaveCompletion>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
            case (.m_fetchResource__resource(let lhsResource), .m_fetchResource__resource(let rhsResource)):
                guard Parameter.compare(lhs: lhsResource, rhs: rhsResource, with: matcher) else { return false } 
                return true 
            case (.m_removeResource__resource(let lhsResource), .m_removeResource__resource(let rhsResource)):
                guard Parameter.compare(lhs: lhsResource, rhs: rhsResource, with: matcher) else { return false } 
                return true 
            case (.m_persistObjects__objectssaveCompletion_saveCompletion(let lhsObjects, let lhsSavecompletion), .m_persistObjects__objectssaveCompletion_saveCompletion(let rhsObjects, let rhsSavecompletion)):
                guard Parameter.compare(lhs: lhsObjects, rhs: rhsObjects, with: matcher) else { return false } 
                guard Parameter.compare(lhs: lhsSavecompletion, rhs: rhsSavecompletion, with: matcher) else { return false } 
                return true 
            default: return false
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_fetchResource__resource(p0): return p0.intValue
            case let .m_removeResource__resource(p0): return p0.intValue
            case let .m_persistObjects__objectssaveCompletion_saveCompletion(p0, p1): return p0.intValue + p1.intValue
            }
        }
    }

    class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [SwiftyMocky.Product]) {
            self.method = method
            super.init(products)
        }


        static func fetchResource<T>(_ resource: Parameter<Resource>, willReturn: SignalProducer<T, PersistenceLayerError>...) -> MethodStub {
            return Given(method: .m_fetchResource__resource(`resource`), products: willReturn.map({ SwiftyMocky.Product.return($0) }))
        }
        @available(*, deprecated, message: "This constructor is deprecated, and will be removed in v3.1 Possible fix:  remove `resource` label")
		static func fetchResource<T>(resource: Parameter<Resource>, willReturn: SignalProducer<T, PersistenceLayerError>...) -> MethodStub {
            return Given(method: .m_fetchResource__resource(`resource`), products: willReturn.map({ SwiftyMocky.Product.return($0) }))
        }
        static func removeResource(_ resource: Parameter<Resource>, willReturn: SignalProducer<Bool, PersistenceLayerError>...) -> MethodStub {
            return Given(method: .m_removeResource__resource(`resource`), products: willReturn.map({ SwiftyMocky.Product.return($0) }))
        }
        @available(*, deprecated, message: "This constructor is deprecated, and will be removed in v3.1 Possible fix:  remove `resource` label")
		static func removeResource(resource: Parameter<Resource>, willReturn: SignalProducer<Bool, PersistenceLayerError>...) -> MethodStub {
            return Given(method: .m_removeResource__resource(`resource`), products: willReturn.map({ SwiftyMocky.Product.return($0) }))
        }
        static func fetchResource<T>(_ resource: Parameter<Resource>, willProduce: (Stubber<SignalProducer<T, PersistenceLayerError>>) -> Void) -> MethodStub {
            let willReturn: [SignalProducer<T, PersistenceLayerError>] = []
			let given: Given = { return Given(method: .m_fetchResource__resource(`resource`), products: willReturn.map({ SwiftyMocky.Product.return($0) })) }()
			let stubber = given.stub(for: (SignalProducer<T, PersistenceLayerError>).self)
			willProduce(stubber)
			return given
        }
        static func removeResource(_ resource: Parameter<Resource>, willProduce: (Stubber<SignalProducer<Bool, PersistenceLayerError>>) -> Void) -> MethodStub {
            let willReturn: [SignalProducer<Bool, PersistenceLayerError>] = []
			let given: Given = { return Given(method: .m_removeResource__resource(`resource`), products: willReturn.map({ SwiftyMocky.Product.return($0) })) }()
			let stubber = given.stub(for: (SignalProducer<Bool, PersistenceLayerError>).self)
			willProduce(stubber)
			return given
        }
    }

    struct Verify {
        fileprivate var method: MethodType

        static func fetchResource(_ resource: Parameter<Resource>) -> Verify { return Verify(method: .m_fetchResource__resource(`resource`))}
        @available(*, deprecated, message: "This constructor is deprecated, and will be removed in v3.1 Possible fix:  remove `resource` label")
		static func fetchResource(resource: Parameter<Resource>) -> Verify { return Verify(method: .m_fetchResource__resource(`resource`))}
        static func removeResource(_ resource: Parameter<Resource>) -> Verify { return Verify(method: .m_removeResource__resource(`resource`))}
        @available(*, deprecated, message: "This constructor is deprecated, and will be removed in v3.1 Possible fix:  remove `resource` label")
		static func removeResource(resource: Parameter<Resource>) -> Verify { return Verify(method: .m_removeResource__resource(`resource`))}
        static func persistObjects<T>(_ objects: Parameter<T>, saveCompletion: Parameter<PersistenceSaveCompletion>) -> Verify { return Verify(method: .m_persistObjects__objectssaveCompletion_saveCompletion(`objects`.wrapAsGeneric(), `saveCompletion`))}
        @available(*, deprecated, message: "This constructor is deprecated, and will be removed in v3.1 Possible fix:  remove `objects` label")
		static func persistObjects<T>(objects: Parameter<T>, saveCompletion: Parameter<PersistenceSaveCompletion>) -> Verify { return Verify(method: .m_persistObjects__objectssaveCompletion_saveCompletion(`objects`.wrapAsGeneric(), `saveCompletion`))}
    }

    struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        static func fetchResource(_ resource: Parameter<Resource>, perform: @escaping (Resource) -> Void) -> Perform {
            return Perform(method: .m_fetchResource__resource(`resource`), performs: perform)
        }
        @available(*, deprecated, message: "This constructor is deprecated, and will be removed in v3.1 Possible fix:  remove `resource` label")
		static func fetchResource(resource: Parameter<Resource>, perform: @escaping (Resource) -> Void) -> Perform {
            return Perform(method: .m_fetchResource__resource(`resource`), performs: perform)
        }
        static func removeResource(_ resource: Parameter<Resource>, perform: @escaping (Resource) -> Void) -> Perform {
            return Perform(method: .m_removeResource__resource(`resource`), performs: perform)
        }
        @available(*, deprecated, message: "This constructor is deprecated, and will be removed in v3.1 Possible fix:  remove `resource` label")
		static func removeResource(resource: Parameter<Resource>, perform: @escaping (Resource) -> Void) -> Perform {
            return Perform(method: .m_removeResource__resource(`resource`), performs: perform)
        }
        static func persistObjects<T>(_ objects: Parameter<T>, saveCompletion: Parameter<PersistenceSaveCompletion>, perform: @escaping (T, @escaping PersistenceSaveCompletion) -> Void) -> Perform {
            return Perform(method: .m_persistObjects__objectssaveCompletion_saveCompletion(`objects`.wrapAsGeneric(), `saveCompletion`), performs: perform)
        }
        @available(*, deprecated, message: "This constructor is deprecated, and will be removed in v3.1 Possible fix:  remove `objects` label")
		static func persistObjects<T>(objects: Parameter<T>, saveCompletion: Parameter<PersistenceSaveCompletion>, perform: @escaping (T, @escaping PersistenceSaveCompletion) -> Void) -> Perform {
            return Perform(method: .m_persistObjects__objectssaveCompletion_saveCompletion(`objects`.wrapAsGeneric(), `saveCompletion`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let invocations = matchingCalls(method.method)
        MockyAssert(count.matches(invocations.count), "Expeced: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }
    private func methodReturnValue(_ method: MethodType) throws -> SwiftyMocky.Product {
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleMissingStubError(message: message, file: file, line: line)
        #endif
    }
}

// MARK: - PostDetailsRouting
class PostDetailsRoutingMock: PostDetailsRouting, Mock {
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    typealias PropertyStub = Given
    typealias MethodStub = Given
    typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }






    fileprivate struct MethodType {
        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool { return true }
        func intValue() -> Int { return 0 }
    }

    class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [SwiftyMocky.Product]) {
            self.method = method
            super.init(products)
        }


    }

    struct Verify {
        fileprivate var method: MethodType

    }

    struct Perform {
        fileprivate var method: MethodType
        var performs: Any

    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let invocations = matchingCalls(method.method)
        MockyAssert(count.matches(invocations.count), "Expeced: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }
    private func methodReturnValue(_ method: MethodType) throws -> SwiftyMocky.Product {
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleMissingStubError(message: message, file: file, line: line)
        #endif
    }
}

// MARK: - PostsListRouting
class PostsListRoutingMock: PostsListRouting, Mock {
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    typealias PropertyStub = Given
    typealias MethodStub = Given
    typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }





    func showPost(id: Int, action: @escaping (PostListAction) -> Void) {
        addInvocation(.m_showPost__id_idaction_action(Parameter<Int>.value(`id`), Parameter<(PostListAction) -> Void>.value(`action`)))
		let perform = methodPerformValue(.m_showPost__id_idaction_action(Parameter<Int>.value(`id`), Parameter<(PostListAction) -> Void>.value(`action`))) as? (Int, @escaping (PostListAction) -> Void) -> Void
		perform?(`id`, `action`)
    }


    fileprivate enum MethodType {
        case m_showPost__id_idaction_action(Parameter<Int>, Parameter<(PostListAction) -> Void>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
            case (.m_showPost__id_idaction_action(let lhsId, let lhsAction), .m_showPost__id_idaction_action(let rhsId, let rhsAction)):
                guard Parameter.compare(lhs: lhsId, rhs: rhsId, with: matcher) else { return false } 
                guard Parameter.compare(lhs: lhsAction, rhs: rhsAction, with: matcher) else { return false } 
                return true 
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_showPost__id_idaction_action(p0, p1): return p0.intValue + p1.intValue
            }
        }
    }

    class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [SwiftyMocky.Product]) {
            self.method = method
            super.init(products)
        }


    }

    struct Verify {
        fileprivate var method: MethodType

        static func showPost(id: Parameter<Int>, action: Parameter<(PostListAction) -> Void>) -> Verify { return Verify(method: .m_showPost__id_idaction_action(`id`, `action`))}
    }

    struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        static func showPost(id: Parameter<Int>, action: Parameter<(PostListAction) -> Void>, perform: @escaping (Int, @escaping (PostListAction) -> Void) -> Void) -> Perform {
            return Perform(method: .m_showPost__id_idaction_action(`id`, `action`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let invocations = matchingCalls(method.method)
        MockyAssert(count.matches(invocations.count), "Expeced: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }
    private func methodReturnValue(_ method: MethodType) throws -> SwiftyMocky.Product {
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleMissingStubError(message: message, file: file, line: line)
        #endif
    }
}


