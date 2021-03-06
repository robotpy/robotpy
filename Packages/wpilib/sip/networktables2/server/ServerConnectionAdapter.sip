// This file is part of the RobotPy wpilib package.
//
// Copyright (c) 2013 Peter Johnson
// 
// Permission is hereby granted, free of charge, to any person obtaining a
// copy of this software and associated documentation files (the "Software"),
// to deal in the Software without restriction, including without limitation
// the rights to use, copy, modify, merge, publish, distribute, sublicense,
// and/or sell copies of the Software, and to permit persons to whom the
// Software is furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
// DEALINGS IN THE SOFTWARE.
//

class ServerConnectionAdapter : ConnectionAdapter, IncomingEntryReceiver, FlushableOutgoingEntryReceiver
{
%TypeHeaderCode
#include <WPILib/networktables2/server/ServerConnectionAdapter.h>
%End
public:
	ServerConnectionAdapter(IOStream* stream, ServerNetworkTableEntryStore& entryStore, IncomingEntryReceiver& transactionReceiver, ServerAdapterManager& adapterListener, NetworkTableEntryTypeManager& typeManager, NTThreadManager& threadManager);
	virtual ~ServerConnectionAdapter();
	
	void shutdown(bool closeStream);
	void offerOutgoingAssignment(NetworkTableEntry* entry);
	void offerOutgoingUpdate(NetworkTableEntry* entry);

	void flush();

	ServerConnectionState* getConnectionState();

	void ensureAlive();
	
	bool IsAdapterListenerClosed();
	ConnectionAdapter& AsConnectionAdapter();
	
protected:
	
	bool keepAlive();
	//void badMessage(BadMessageException& e);
	//void ioException(IOException& e);
	void clientHello(ProtocolVersion protocolRevision);
	void protocolVersionUnsupported(ProtocolVersion protocolRevision);
	void serverHelloComplete();
	void offerIncomingAssignment(NetworkTableEntry* entry);
	//void offerIncomingUpdate(NetworkTableEntry* entry, SequenceNumber sequenceNumber, EntryValue value);
	NetworkTableEntry* GetEntry(EntryId id);
	
private:
	ServerConnectionAdapter(const ServerConnectionAdapter&);
};
