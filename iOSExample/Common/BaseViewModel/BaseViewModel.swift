//
//  BaseViewModel.swift
//  iOSExample
//
//  Created by 10-N3344 on 8/19/24.
//

import Foundation
import Combine
import Network
#if canImport(Moya)
import Moya
import Alamofire
#endif
#if canImport(SocketIO)
import SocketIO
#endif

class BaseViewModel: ObservableObject {

    struct BaseAction {
        var socketConnect = PassthroughSubject<Void, Never>()
        var socketDisconnet = PassthroughSubject<Void, Never>()
    }

    struct BaseState {
#if canImport(Moya)
        var apiResult = PassthroughSubject<(Bool, MedisayAPI, Any?), Never>() // 서버 결과
        var apiErrorMessage = PassthroughSubject<(Bool, MedisayAPI, String), Never>() // 서버 에러메시지.
#endif
#if canImport(SocketIO)
        var socketResult = PassthroughSubject<(SocketCallBackType, [Any]), Never>() // 서버 에러 공통
#endif
    }

    // MARK: - Socket variables
#if canImport(SocketIO)
    var socketManager: SocketManager?
    var socketDefault: SocketIOClient?
    var isSocketReconnect: Bool = false
#endif

    // MARK: - Network reachability variables
    var networkStatus: NWPath.Status = .satisfied
#if canImport(Moya)
    var api = APIProvider()
#endif

    // MARK: - variables
    var baseAction = BaseAction()
    var baseState = BaseState()
    var cancellables: Set<AnyCancellable> = []

    init() {
        baseBinding()
    }

    deinit {
        socketDisconnect()
    }

    private func baseBinding() {
        // 소켓 연결
        baseAction.socketConnect.sink { [weak self] _ in
            guard let self = self else { return }
            self.socketConnect()
        }.store(in: &cancellables)

        // 소켓 끊기
        baseAction.socketDisconnet.sink { [weak self] _ in
            guard let self = self else { return }
            self.socketDisconnect()
        }.store(in: &cancellables)
    }
}

// MARK: - Socket Method
extension BaseViewModel {
    
    private func socketConnect() {
#if canImport(SocketIO)
        let status = isSocketConnected()
        if status == .connected || status == .connecting {
            socketDisconnect()
        }
        #if DEVELOP
        // , .forceNew(true), .forcePolling(true), .reconnects(true), .reconnectWait(3), .reconnectWaitMax(6), .reconnects(false), .reconnectAttempts(0)
        socketManager = SocketManager(socketURL: URL(string: Bundle.getInfoPlistValue(forKey: .baseSocketURL))!, config: [.log(true), .forceWebsockets(true), .forcePolling(true), .version(.two)])
        #else
        socketManager = SocketManager(socketURL: URL(string: Bundle.getInfoPlistValue(forKey: .baseSocketURL))!, config: [.forceWebsockets(true), .forcePolling(true), .version(.two)])
        #endif
        socketDefault = socketManager?.defaultSocket

        socketBaseBinding()
        socketDefault?.connect()
#endif
    }

    private func socketDisconnect() {
#if canImport(SocketIO)
        guard let socket = socketDefault else { return }
        socket.disconnect()
        socketDefault = nil
        socketManager = nil
#endif
    }

    private func socketBaseBinding() {
#if canImport(SocketIO)
        guard let socket = socketDefault else { return }
#if DEVELOP
        socket.onAny {
            if $0.event == "error" {
                DLog("items: \($0.items ?? [])")
            }
            DLog("# >>> Socket Got event: \($0.event), with items: \($0.items ?? [])")
        }
#endif

        // MARK: - Socket clientEvent
        socket.on(clientEvent: .connect) { [weak self] data, ack in
            guard let self = self else { return }
            // DLog("# >>> Socket Connected!! data: {\(data)} ack: {\(ack)}")
            self.baseState.socketResult.send((.connect, data))
        }

        socket.on(clientEvent: .disconnect) { [weak self] data, ack in
            guard let self = self else { return }
            // DLog("# >>> Socket Disconnected!! data: {\(data)} ack: {\(ack)}")
            self.baseState.socketResult.send((.disconnect, data))
        }

        socket.on(clientEvent: .error) { data, ack in
            var reasonParam: [String: Any] = [:]
            reasonParam["Data"] = data
            reasonParam["Ack"] = ack.description
            DLog("Socket ClientEvent Error", level: .error, param: reasonParam)
            self.baseState.socketResult.send((.error, data))
        }

//        socket.on(clientEvent: .ping) { data, ack in
//            guard let self = self else { return }
//            DLog("# >>> Socket ping data: {\(data)} ack: {\(ack)}")
//        }

//        socket.on(clientEvent: .pong) { data, ack in
//            guard let self = self else { return }
//            DLog("# >>> Socket pong data: {\(data)} ack: {\(ack)}")
//        }

//        socket.on(clientEvent: .statusChange) { data, ack in
//            guard let self = self else { return }
//            DLog("# >>> Socket statusChange data: {\(data)} ack: {\(ack)}")
//        }

        socket.on(clientEvent: .reconnect) { [weak self] data, ack in
            guard let self = self else { return }
            self.isSocketReconnect = true
            self.baseState.socketResult.send((.reconnect, data))
        }

//        socket.on(clientEvent: .reconnectAttempt) { data, ack in
//             guard let self = self else { return }
//            DLog("# >>> Socket reconnectAttempt data: {\(data)} ack: {\(ack)}")
//        }

//        socket.on(clientEvent: .websocketUpgrade) { data, ack in
//            guard let self = self else { return }
//            DLog("# >>> Socket websocketUpgrade data: {\(data)} ack: {\(ack)}")
//        }

        // MARK: - Socket Custom Event
//        socket.on(SocketCallBackType.notice.rawValue) {[weak self] data, ack in
//            guard let self = self else { return }
//            self.baseState.socketResult.send((.notice, data))
//        }
#endif
    }
#if canImport(SocketIO)
    func isSocketConnected() -> SocketIOStatus {

        guard let status = socketDefault?.status else {
            return .notConnected
        }
        return status
    }
#endif
}
