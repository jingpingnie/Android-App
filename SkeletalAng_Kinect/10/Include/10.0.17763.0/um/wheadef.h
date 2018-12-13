/*++

Copyright (c) 2007 Microsoft Corporation

Module Name:

    wheadef.h

Abstract:

    This header file defines structures and identifiers used in software
    interfaces for the windows hardware error reporting system. It includes the
    common platform error record and error source descriptor definitions.

--*/

#ifndef _WHEADEF_H_
#define _WHEADEF_H_

#include <winapifamily.h>

#pragma region Desktop Family
#if WINAPI_FAMILY_PARTITION(WINAPI_PARTITION_DESKTOP)

#include <cper.h>

//------------------------------------------------------ WHEA_ERROR_SOURCE_TYPE

#define WHEA_PHYSICAL_ADDRESS LARGE_INTEGER

//
// This enumeration defines the various types of error sources that a platform
// can expose to the operating system.
//

typedef enum _WHEA_ERROR_SOURCE_TYPE {
    WheaErrSrcTypeMCE          = 0x00,    // Machine Check Exception
    WheaErrSrcTypeCMC          = 0x01,    // Corrected Machine Check
    WheaErrSrcTypeCPE          = 0x02,    // Corrected Platform Error
    WheaErrSrcTypeNMI          = 0x03,    // Non-Maskable Interrupt
    WheaErrSrcTypePCIe         = 0x04,    // PCI Express Error
    WheaErrSrcTypeGeneric      = 0x05,    // Other types of error sources
    WheaErrSrcTypeINIT         = 0x06,    // IA64 INIT Error Source
    WheaErrSrcTypeBOOT         = 0x07,    // BOOT Error Source
    WheaErrSrcTypeSCIGeneric   = 0x08,    // SCI-based generic error source
    WheaErrSrcTypeIPFMCA       = 0x09,    // Itanium Machine Check Abort
    WheaErrSrcTypeIPFCMC       = 0x0a,    // Itanium Machine check
    WheaErrSrcTypeIPFCPE       = 0x0b,    // Itanium Corrected Platform Error
    WheaErrSrcTypeGenericV2    = 0x0c,    // Other types of error sources v2
    WheaErrSrcTypeSCIGenericV2 = 0x0d,    // SCI-based GHESv2
    WheaErrSrcTypeMax
} WHEA_ERROR_SOURCE_TYPE, *PWHEA_ERROR_SOURCE_TYPE;

//
// Error sources have a runtime state associated with them. The following are
// the valid states for an error source.
//

typedef enum _WHEA_ERROR_SOURCE_STATE {
    WheaErrSrcStateStopped = 0x01,
    WheaErrSrcStateStarted = 0x02
} WHEA_ERROR_SOURCE_STATE, *PWHEA_ERROR_SOURCE_STATE;

#define WHEA_ERROR_SOURCE_DESCRIPTOR_VERSION_10          10

#define WHEA_MAX_MC_BANKS                                32

#define WHEA_ERROR_SOURCE_FLAG_FIRMWAREFIRST             0x00000001
#define WHEA_ERROR_SOURCE_FLAG_GLOBAL                    0x00000002
#define WHEA_ERROR_SOURCE_FLAG_PREALLOCATE_PER_PROCESSOR 0x00000004
#define WHEA_ERROR_SOURCE_FLAG_DEFAULTSOURCE             0x80000000

#define WHEA_ERROR_SOURCE_DESCRIPTOR_TYPE_XPFMCE         0
#define WHEA_ERROR_SOURCE_DESCRIPTOR_TYPE_XPFCMC         1
#define WHEA_ERROR_SOURCE_DESCRIPTOR_TYPE_XPFNMI         2
#define WHEA_ERROR_SOURCE_DESCRIPTOR_TYPE_IPFMCA         3
#define WHEA_ERROR_SOURCE_DESCRIPTOR_TYPE_IPFCMC         4
#define WHEA_ERROR_SOURCE_DESCRIPTOR_TYPE_IPFCPE         5
#define WHEA_ERROR_SOURCE_DESCRIPTOR_TYPE_AERROOTPORT    6
#define WHEA_ERROR_SOURCE_DESCRIPTOR_TYPE_AERENDPOINT    7
#define WHEA_ERROR_SOURCE_DESCRIPTOR_TYPE_AERBRIDGE      8
#define WHEA_ERROR_SOURCE_DESCRIPTOR_TYPE_GENERIC        9
#define WHEA_ERROR_SOURCE_DESCRIPTOR_TYPE_GENERIC_V2     10

#define WHEA_XPF_MC_BANK_STATUSFORMAT_IA32MCA            0
#define WHEA_XPF_MC_BANK_STATUSFORMAT_Intel64MCA         1
#define WHEA_XPF_MC_BANK_STATUSFORMAT_AMD64MCA           2

#define WHEA_NOTIFICATION_TYPE_POLLED                    0
#define WHEA_NOTIFICATION_TYPE_EXTERNALINTERRUPT         1
#define WHEA_NOTIFICATION_TYPE_LOCALINTERRUPT            2
#define WHEA_NOTIFICATION_TYPE_SCI                       3
#define WHEA_NOTIFICATION_TYPE_NMI                       4
#define WHEA_NOTIFICATION_TYPE_CMCI                      5
#define WHEA_NOTIFICATION_TYPE_MCE                       6
#define WHEA_NOTIFICATION_TYPE_GPIO_SIGNAL               7
#define WHEA_NOTIFICATION_TYPE_ARMV8_SEA                 8
#define WHEA_NOTIFICATION_TYPE_ARMV8_SEI                 9
#define WHEA_NOTIFICATION_TYPE_EXTERNALINTERRUPT_GSIV    10
#define WHEA_NOTIFICATION_TYPE_SDEI                      11

#include <pshpack1.h>

//------------------------------------------------ WHEA_ERROR_SOURCE_DESCRIPTOR

typedef union _WHEA_NOTIFICATION_FLAGS {
    struct {
        USHORT PollIntervalRW:1;
        USHORT SwitchToPollingThresholdRW:1;
        USHORT SwitchToPollingWindowRW:1;
        USHORT ErrorThresholdRW:1;
        USHORT ErrorThresholdWindowRW:1;
        USHORT Reserved:11;
    } DUMMYSTRUCTNAME;
    USHORT AsUSHORT;
} WHEA_NOTIFICATION_FLAGS, *PWHEA_NOTIFICATION_FLAGS;

typedef union _XPF_MC_BANK_FLAGS {
    struct {
        UCHAR ClearOnInitializationRW:1;
        UCHAR ControlDataRW:1;
        UCHAR Reserved:6;
    } DUMMYSTRUCTNAME;
    UCHAR AsUCHAR;
} XPF_MC_BANK_FLAGS, *PXPF_MC_BANK_FLAGS;

typedef union _XPF_MCE_FLAGS {
    struct {
        ULONG MCG_CapabilityRW:1;
        ULONG MCG_GlobalControlRW:1;
        ULONG Reserved:30;
    } DUMMYSTRUCTNAME;
    ULONG AsULONG;
} XPF_MCE_FLAGS, *PXPF_MCE_FLAGS;

typedef union _AER_ROOTPORT_DESCRIPTOR_FLAGS {
    struct {
        USHORT UncorrectableErrorMaskRW:1;
        USHORT UncorrectableErrorSeverityRW:1;
        USHORT CorrectableErrorMaskRW:1;
        USHORT AdvancedCapsAndControlRW:1;
        USHORT RootErrorCommandRW:1;
        USHORT Reserved:11;
    } DUMMYSTRUCTNAME;
    USHORT AsUSHORT;
} AER_ROOTPORT_DESCRIPTOR_FLAGS, *PAER_ROOTPORT_DESCRIPTOR_FLAGS;

typedef union _AER_ENDPOINT_DESCRIPTOR_FLAGS {
    struct {
        USHORT UncorrectableErrorMaskRW:1;
        USHORT UncorrectableErrorSeverityRW:1;
        USHORT CorrectableErrorMaskRW:1;
        USHORT AdvancedCapsAndControlRW:1;
        USHORT Reserved:12;
    } DUMMYSTRUCTNAME;
    USHORT AsUSHORT;
} AER_ENDPOINT_DESCRIPTOR_FLAGS, *PAER_ENDPOINT_DESCRIPTOR_FLAGS;

typedef union _AER_BRIDGE_DESCRIPTOR_FLAGS {
    struct {
        USHORT UncorrectableErrorMaskRW:1;
        USHORT UncorrectableErrorSeverityRW:1;
        USHORT CorrectableErrorMaskRW:1;
        USHORT AdvancedCapsAndControlRW:1;
        USHORT SecondaryUncorrectableErrorMaskRW:1;
        USHORT SecondaryUncorrectableErrorSevRW:1;
        USHORT SecondaryCapsAndControlRW:1;
        USHORT Reserved:9;
    } DUMMYSTRUCTNAME;
    USHORT AsUSHORT;
} AER_BRIDGE_DESCRIPTOR_FLAGS, *PAER_BRIDGE_DESCRIPTOR_FLAGS;

//
// The following structure is used to describe how a given error source reports
// errors to the OS.
//

typedef struct _WHEA_NOTIFICATION_DESCRIPTOR {
    UCHAR Type;
    UCHAR Length;
    WHEA_NOTIFICATION_FLAGS Flags;

    union {
        struct {
            ULONG PollInterval;
        } Polled;

        struct {
            ULONG PollInterval;
            ULONG Vector;
            ULONG SwitchToPollingThreshold;
            ULONG SwitchToPollingWindow;
            ULONG ErrorThreshold;
            ULONG ErrorThresholdWindow;
        } Interrupt;

        struct {
            ULONG PollInterval;
            ULONG Vector;
            ULONG SwitchToPollingThreshold;
            ULONG SwitchToPollingWindow;
            ULONG ErrorThreshold;
            ULONG ErrorThresholdWindow;
        } LocalInterrupt;

        struct {
            ULONG PollInterval;
            ULONG Vector;
            ULONG SwitchToPollingThreshold;
            ULONG SwitchToPollingWindow;
            ULONG ErrorThreshold;
            ULONG ErrorThresholdWindow;
        } Sci;

        struct {
            ULONG PollInterval;
            ULONG Vector;
            ULONG SwitchToPollingThreshold;
            ULONG SwitchToPollingWindow;
            ULONG ErrorThreshold;
            ULONG ErrorThresholdWindow;
        } Nmi;

        struct {
            ULONG PollInterval;
            ULONG Vector;
            ULONG SwitchToPollingThreshold;
            ULONG SwitchToPollingWindow;
            ULONG ErrorThreshold;
            ULONG ErrorThresholdWindow;
        } Sea;

        struct {
            ULONG PollInterval;
            ULONG Vector;
            ULONG SwitchToPollingThreshold;
            ULONG SwitchToPollingWindow;
            ULONG ErrorThreshold;
            ULONG ErrorThresholdWindow;
        } Sei;

        struct {
            ULONG PollInterval;
            ULONG Vector;
            ULONG SwitchToPollingThreshold;
            ULONG SwitchToPollingWindow;
            ULONG ErrorThreshold;
            ULONG ErrorThresholdWindow;
        } Gsiv;
    } u;
} WHEA_NOTIFICATION_DESCRIPTOR, *PWHEA_NOTIFICATION_DESCRIPTOR;

//
// The following structure describes an XPF machine check bank. It identifies
// the bank with a BankNumber and it contains information that is used to
// configure the bank. MCE and CMC error sources make use of this descriptor
// to describe and configure each bank.
//

typedef struct _WHEA_XPF_MC_BANK_DESCRIPTOR {
    UCHAR BankNumber;
    BOOLEAN ClearOnInitialization;
    UCHAR StatusDataFormat;
    XPF_MC_BANK_FLAGS Flags;
    ULONG ControlMsr;
    ULONG StatusMsr;
    ULONG AddressMsr;
    ULONG MiscMsr;
    ULONGLONG ControlData;
} WHEA_XPF_MC_BANK_DESCRIPTOR, *PWHEA_XPF_MC_BANK_DESCRIPTOR;

//
// The following structure describes an XPF platform's machine check exception
// error source mechanism. The information represented in this structure tells
// the OS how to configure the platform's MCE error source.
//

typedef struct _WHEA_XPF_MCE_DESCRIPTOR {
    USHORT Type;
    UCHAR Enabled;
    UCHAR NumberOfBanks;
    XPF_MCE_FLAGS Flags;
    ULONGLONG MCG_Capability;
    ULONGLONG MCG_GlobalControl;
    WHEA_XPF_MC_BANK_DESCRIPTOR Banks[WHEA_MAX_MC_BANKS];
} WHEA_XPF_MCE_DESCRIPTOR, *PWHEA_XPF_MCE_DESCRIPTOR;

//
// The following structure describes an XPF platform's corrected machine check
// error source mechanism. The information represented in this structure tells
// the OS how to configure the platform's CMC error source.
//

typedef struct _WHEA_XPF_CMC_DESCRIPTOR {
    USHORT Type;
    BOOLEAN Enabled;
    UCHAR NumberOfBanks;
    ULONG Reserved;
    WHEA_NOTIFICATION_DESCRIPTOR Notify;
    WHEA_XPF_MC_BANK_DESCRIPTOR Banks[WHEA_MAX_MC_BANKS];
} WHEA_XPF_CMC_DESCRIPTOR, *PWHEA_XPF_CMC_DESCRIPTOR;

typedef struct _WHEA_PCI_SLOT_NUMBER {
    union {
        struct {
            ULONG DeviceNumber:5;
            ULONG FunctionNumber:3;
            ULONG Reserved:24;
        } bits;
        ULONG AsULONG;
    } u;
} WHEA_PCI_SLOT_NUMBER, *PWHEA_PCI_SLOT_NUMBER;

//
// The following structure describes an XPF platform's non-maskable interrupt
// error source mechanism. The information represented in this structure tells
// the OS how to configure the platform's NMI error source.
//

typedef struct _WHEA_XPF_NMI_DESCRIPTOR {
    USHORT Type;
    BOOLEAN Enabled;
} WHEA_XPF_NMI_DESCRIPTOR, *PWHEA_XPF_NMI_DESCRIPTOR;

//
// The following structure describes a platform's PCI Express AER root port
// error source. The information represented in this structure tells the OS how
// to configure the root port's AER settings.
//

typedef struct _WHEA_AER_ROOTPORT_DESCRIPTOR {
    USHORT Type;
    BOOLEAN Enabled;
    UCHAR Reserved;
    ULONG BusNumber;
    WHEA_PCI_SLOT_NUMBER Slot;
    USHORT DeviceControl;
    AER_ROOTPORT_DESCRIPTOR_FLAGS Flags;
    ULONG UncorrectableErrorMask;
    ULONG UncorrectableErrorSeverity;
    ULONG CorrectableErrorMask;
    ULONG AdvancedCapsAndControl;
    ULONG RootErrorCommand;
} WHEA_AER_ROOTPORT_DESCRIPTOR, *PWHEA_AER_ROOTPORT_DESCRIPTOR;

//
// The following structure describes a platform's PCI Express AER endpoint
// error source. The information represented in this structure tells the OS how
// to configure the device's AER settings.
//

typedef struct _WHEA_AER_ENDPOINT_DESCRIPTOR {
    USHORT Type;
    BOOLEAN Enabled;
    UCHAR Reserved;
    ULONG BusNumber;
    WHEA_PCI_SLOT_NUMBER Slot;
    USHORT DeviceControl;
    AER_ENDPOINT_DESCRIPTOR_FLAGS Flags;
    ULONG UncorrectableErrorMask;
    ULONG UncorrectableErrorSeverity;
    ULONG CorrectableErrorMask;
    ULONG AdvancedCapsAndControl;
} WHEA_AER_ENDPOINT_DESCRIPTOR, *PWHEA_AER_ENDPOINT_DESCRIPTOR;

//
// The following structure describes a platform's PCI Express AER bridge
// error source. The information represented in this structure tells the OS how
// to configure the bridge's AER settings.
//

typedef struct _WHEA_AER_BRIDGE_DESCRIPTOR {
    USHORT Type;
    BOOLEAN Enabled;
    UCHAR Reserved;
    ULONG BusNumber;
    WHEA_PCI_SLOT_NUMBER Slot;
    USHORT DeviceControl;
    AER_BRIDGE_DESCRIPTOR_FLAGS Flags;
    ULONG UncorrectableErrorMask;
    ULONG UncorrectableErrorSeverity;
    ULONG CorrectableErrorMask;
    ULONG AdvancedCapsAndControl;
    ULONG SecondaryUncorrectableErrorMask;
    ULONG SecondaryUncorrectableErrorSev;
    ULONG SecondaryCapsAndControl;
} WHEA_AER_BRIDGE_DESCRIPTOR, *PWHEA_AER_BRIDGE_DESCRIPTOR;

//
// The following structure describes a generic error source to the OS. Using
// the information in this structure the OS is able to configure a handler for
// the generic error source.
//

typedef struct _WHEA_GENERIC_ERROR_DESCRIPTOR {

    //
    // Type is WHEA_ERROR_SOURCE_DESCRIPTOR_TYPE_GENERIC.
    //

    USHORT Type;

    //
    // This field is reserved.
    //

    UCHAR Reserved;

    //
    // Indicates whether the generic error source is to be enabled.
    //

    UCHAR Enabled;

    //
    // Length of the error status block.
    //

    ULONG ErrStatusBlockLength;

    //
    // If this generic error source relates back to another error source, keep
    // it's identifier here.
    //

    ULONG RelatedErrorSourceId;

    //
    // The following 5 fields have the same layout as a GEN_ADDR structure. They
    // describe the address at which the OS reads error status information
    // from the error source.
    //

    UCHAR ErrStatusAddressSpaceID;
    UCHAR ErrStatusAddressBitWidth;
    UCHAR ErrStatusAddressBitOffset;
    UCHAR ErrStatusAddressAccessSize;
    WHEA_PHYSICAL_ADDRESS ErrStatusAddress;

    //
    // Notify describes how the generic error source notifies the OS that error
    // information is available.
    //

    WHEA_NOTIFICATION_DESCRIPTOR Notify;

} WHEA_GENERIC_ERROR_DESCRIPTOR, *PWHEA_GENERIC_ERROR_DESCRIPTOR;

typedef struct _WHEA_GENERIC_ERROR_DESCRIPTOR_V2 {

    //
    // Type is WHEA_ERROR_SOURCE_DESCRIPTOR_TYPE_GENERIC_V2.
    //

    USHORT Type;

    //
    // This field is reserved.
    //

    UCHAR Reserved;

    //
    // Indicates whether the generic error source is to be enabled.
    //

    UCHAR Enabled;

    //
    // Length of the error status block.
    //

    ULONG ErrStatusBlockLength;

    //
    // If this generic error source relates back to another error source, keep
    // it's identifier here.
    //

    ULONG RelatedErrorSourceId;

    //
    // The following 5 fields have the same layout as a GEN_ADDR structure. They
    // describe the address at which the OS reads error status information
    // from the error source.
    //

    UCHAR ErrStatusAddressSpaceID;
    UCHAR ErrStatusAddressBitWidth;
    UCHAR ErrStatusAddressBitOffset;
    UCHAR ErrStatusAddressAccessSize;
    WHEA_PHYSICAL_ADDRESS ErrStatusAddress;
    
    //
    // Notify describes how the generic error source notifies the OS that error
    // information is available.
    //

    WHEA_NOTIFICATION_DESCRIPTOR Notify;

    //
    // The following 5 fields have the same layout as a GEN_ADDR structure. They
    // describe the address at which the OS will acknoledge the consumption of the
    // error status block.
    //

    UCHAR ReadAckAddressSpaceID;
    UCHAR ReadAckAddressBitWidth;
    UCHAR ReadAckAddressBitOffset;
    UCHAR ReadAckAddressAccessSize;
    WHEA_PHYSICAL_ADDRESS ReadAckAddress;
    ULONGLONG ReadAckPreserveMask;
    ULONGLONG ReadAckWriteMask;

} WHEA_GENERIC_ERROR_DESCRIPTOR_V2, *PWHEA_GENERIC_ERROR_DESCRIPTOR_V2;

typedef struct _WHEA_IPF_MCA_DESCRIPTOR {
    USHORT Type;
    UCHAR Enabled;
    UCHAR Reserved;
} WHEA_IPF_MCA_DESCRIPTOR, *PWHEA_IPF_MCA_DESCRIPTOR;

typedef struct _WHEA_IPF_CMC_DESCRIPTOR {
    USHORT Type;
    UCHAR Enabled;
    UCHAR Reserved;
} WHEA_IPF_CMC_DESCRIPTOR, *PWHEA_IPF_CMC_DESCRIPTOR;

typedef struct _WHEA_IPF_CPE_DESCRIPTOR {
    USHORT Type;
    UCHAR Enabled;
    UCHAR Reserved;
} WHEA_IPF_CPE_DESCRIPTOR, *PWHEA_IPF_CPE_DESCRIPTOR;

typedef struct _WHEA_ERROR_SOURCE_DESCRIPTOR {
    ULONG Length;                                              // +00 (0)
    ULONG Version;                                             // +04 (4)
    WHEA_ERROR_SOURCE_TYPE Type;                               // +08 (8)
    WHEA_ERROR_SOURCE_STATE State;                             // +0C (12)
    ULONG MaxRawDataLength;                                    // +10 (16)
    ULONG NumRecordsToPreallocate;                             // +14 (20)
    ULONG MaxSectionsPerRecord;                                // +18 (24)
    ULONG ErrorSourceId;                                       // +1C (28)
    ULONG PlatformErrorSourceId;                               // +20 (32)
    ULONG Flags;                                               // +24 (36)

    union {                                                    // +28 (40)
        WHEA_XPF_MCE_DESCRIPTOR XpfMceDescriptor;
        WHEA_XPF_CMC_DESCRIPTOR XpfCmcDescriptor;
        WHEA_XPF_NMI_DESCRIPTOR XpfNmiDescriptor;
        WHEA_IPF_MCA_DESCRIPTOR IpfMcaDescriptor;
        WHEA_IPF_CMC_DESCRIPTOR IpfCmcDescriptor;
        WHEA_IPF_CPE_DESCRIPTOR IpfCpeDescriptor;
        WHEA_AER_ROOTPORT_DESCRIPTOR AerRootportDescriptor;
        WHEA_AER_ENDPOINT_DESCRIPTOR AerEndpointDescriptor;
        WHEA_AER_BRIDGE_DESCRIPTOR AerBridgeDescriptor;
        WHEA_GENERIC_ERROR_DESCRIPTOR GenErrDescriptor;
        WHEA_GENERIC_ERROR_DESCRIPTOR_V2 GenErrDescriptorV2;
    } Info;

} WHEA_ERROR_SOURCE_DESCRIPTOR, *PWHEA_ERROR_SOURCE_DESCRIPTOR;

//
// WHEA PFA Policy Type
//

#define    WHEA_DISABLE_OFFLINE        0
#define    WHEA_MEM_PERSISTOFFLINE     1
#define    WHEA_MEM_PFA_DISABLE        2
#define    WHEA_MEM_PFA_PAGECOUNT      3
#define    WHEA_MEM_PFA_THRESHOLD      4
#define    WHEA_MEM_PFA_TIMEOUT        5
#define    WHEA_DISABLE_DUMMY_WRITE    6

#include <poppack.h>

#endif /* WINAPI_FAMILY_PARTITION(WINAPI_PARTITION_DESKTOP) */
#pragma endregion

#endif // #ifndef _WHEADEF_H_

