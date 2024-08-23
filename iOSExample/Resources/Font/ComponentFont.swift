//
//  ComponentFont.swift
//  iOSExample
//
//  Created by 10-N3344 on 8/14/24.
//

// lineHeight 설명
// https://sujinnaljin.medium.com/swift-label의-line-height-설정-및-가운데-정렬-962f7c6e7512

import Foundation
import UIKit

enum ComponentFontCustomFamilyName: String, CaseIterable {
    case fAmericanTypewriter   = "American Typewriter"
    case fAppleSDGothicNeo     = "Apple SD Gothic Neo"
    case fChalkboardSE         = "Chalkboard SE"
    case fCookieRunOTF         = "CookieRunOTF"
    case fDamascus             = "Damascus"
    case fDongle               = "Dongle"
    case fFreesentation        = "Freesentation"
    case fGaegu                = "Gaegu"
    case fGothicA1             = "Gothic A1"
    case fHahmlet              = "Hahmlet"
    case fHelveticaNeue        = "Helvetica Neue"
    case fIBMPlexSansKR        = "IBM Plex Sans KR"
    case fInterop              = "Interop"
    case fKohinoorBangla       = "Kohinoor Bangla"
    case fKohinoorDevanagari   = "Kohinoor Devanagari"
    case fKohinoorGujarati     = "Kohinoor Gujarati"
    case fKohinoorTelugu       = "ohinoor Telugu"
    case fLINESeedSansKR       = "LINE Seed Sans KR"
    case fMangoDdobak          = "Mango Ddobak"
    case fMoveSans             = "MoveSans"
    case fMuktaMahee           = "Mukta Mahee"
    case fNotoSansKannada      = "Noto Sans Kannada"
    case fNotoSansMyanmar      = "Noto Sans Myanmar"
    case fPretendard           = "Pretendard"
    case fSCoreDream           = "S-Core Dream"
    case fSUIT                 = "SUIT"
    case fThonburi             = "Thonburi"
    case fTtangsbudaejjigaeOTF = "Ttangsbudaejjigae OTF"
    case fWantedSans           = "Wanted Sans"
}

extension ComponentFontCustomFamilyName {
    func fontName(weight: UIFont.Weight) -> ComponentFontCustomFontName {
        switch self {
        case .fAmericanTypewriter:
            switch weight {
            case .regular  : return .AmericanTypewriter
            case .semibold : return .AmericanTypewriterSemibold
            case .bold     : return .AmericanTypewriterBold
            default        : return .AmericanTypewriter
            }
        case .fAppleSDGothicNeo:
            switch weight {
            case .regular  : return .AppleSDGothicNeoRegular
            case .semibold : return .AppleSDGothicNeoSemiBold
            case .bold     : return .AppleSDGothicNeoBold
            default        : return .AppleSDGothicNeoRegular
            }
        case .fChalkboardSE:
            switch weight {
            case .regular  : return .ChalkboardSELight
            case .semibold : return .ChalkboardSERegular
            case .bold     : return .ChalkboardSEBold
            default        : return .ChalkboardSELight
            }
        case .fCookieRunOTF:
            switch weight {
            case .regular  : return .CookieRunOTFRegular
            case .semibold : return .CookieRunOTFBold
            case .bold     : return .CookieRunOTFBlack
            default        : return .CookieRunOTFRegular
            }
        case .fDamascus:
            switch weight {
            case .regular  : return .Damascus
            case .semibold : return .DamascusSemiBold
            case .bold     : return .DamascusBold
            default        : return .Damascus
            }
        case .fDongle:
            switch weight {
            case .regular  : return .DongleRegular
            case .semibold : return .DongleLight
            case .bold     : return .DongleBold
            default        : return .DongleRegular
            }
        case .fFreesentation:
            switch weight {
            case .regular  : return .Freesentation4Regular
            case .semibold : return .Freesentation6SemiBold
            case .bold     : return .Freesentation7Bold
            default        : return .Freesentation4Regular
            }
        case .fGaegu:
            switch weight {
            case .regular  : return .GaeguLight
            case .semibold : return .GaeguRegular
            case .bold     : return .GaeguBold
            default        : return .GaeguLight
            }
        case .fGothicA1:
            switch weight {
            case .regular  : return .GothicA1Regular
            case .semibold : return .GothicA1SemiBold
            case .bold     : return .GothicA1Bold
            default        : return .GothicA1Regular
            }
        case .fHahmlet:
            switch weight {
            case .regular  : return .HahmletRegular
            case .semibold : return .HahmletSemiBold
            case .bold     : return .HahmletBold
            default        : return .HahmletRegular
            }
        case .fHelveticaNeue:
            switch weight {
            case .regular  : return .HelveticaNeue
            case .semibold : return .HelveticaNeueMedium
            case .bold     : return .HelveticaNeueBold
            default        : return .HelveticaNeue
            }
        case .fIBMPlexSansKR:
            switch weight {
            case .regular  : return .IBMPlexSansKRRegular
            case .semibold : return .IBMPlexSansKRSemiBold
            case .bold     : return .IBMPlexSansKRBold
            default        : return .IBMPlexSansKRRegular
            }
        case .fInterop:
            switch weight {
            case .regular  : return .InteropRegular
            case .semibold : return .InteropSemiBold
            case .bold     : return .InteropBold
            default        : return .InteropRegular
            }
        case .fKohinoorBangla:
            switch weight {
            case .regular  : return .KohinoorBanglaLight
            case .semibold : return .KohinoorBanglaRegular
            case .bold     : return .KohinoorBanglaSemibold
            default        : return .KohinoorBanglaLight
            }
        case .fKohinoorDevanagari:
            switch weight {
            case .regular  : return .KohinoorDevanagariLight
            case .semibold : return .KohinoorDevanagariRegular
            case .bold     : return .KohinoorDevanagariSemibold
            default        : return .KohinoorDevanagariLight
            }
        case .fKohinoorGujarati:
            switch weight {
            case .regular  : return .KohinoorGujaratiLight
            case .semibold : return .KohinoorGujaratiRegular
            case .bold     : return .KohinoorGujaratiBold
            default        : return .KohinoorGujaratiLight
            }
        case .fKohinoorTelugu:
            switch weight {
            case .regular  : return .KohinoorTeluguLight
            case .semibold : return .KohinoorTeluguRegular
            case .bold     : return .KohinoorTeluguMedium
            default        : return .KohinoorTeluguLight
            }
        case .fLINESeedSansKR:
            switch weight {
            case .regular  : return .LINESeedSansKRThin
            case .semibold : return .LINESeedSansKRRegular
            case .bold     : return .LINESeedSansKRBold
            default        : return .LINESeedSansKRThin
            }
        case .fMangoDdobak:
            switch weight {
            case .regular  : return .MangoDdobakL
            case .semibold : return .MangoDdobakR
            case .bold     : return .MangoDdobakB
            default        : return .MangoDdobakL
            }
        case .fMoveSans:
            switch weight {
            case .regular  : return .MoveSansLight
            case .semibold : return .MoveSansMedium
            case .bold     : return .MoveSansBold
            default        : return .MoveSansLight
            }
        case .fMuktaMahee:
            switch weight {
            case .regular  : return .MuktaMaheeLight
            case .semibold : return .MuktaMaheeRegular
            case .bold     : return .MuktaMaheeBold
            default        : return .MuktaMaheeLight
            }
        case .fNotoSansKannada:
            switch weight {
            case .regular  : return .NotoSansKannadaLight
            case .semibold : return .NotoSansKannadaRegular
            case .bold     : return .NotoSansKannadaBold
            default        : return .NotoSansKannadaLight
            }
        case .fNotoSansMyanmar:
            switch weight {
            case .regular  : return .NotoSansMyanmarLight
            case .semibold : return .NotoSansMyanmarRegular
            case .bold     : return .NotoSansMyanmarBold
            default        : return .NotoSansMyanmarLight
            }
        case .fPretendard:
            switch weight {
            case .regular  : return .PretendardRegular
            case .semibold : return .PretendardSemiBold
            case .bold     : return .PretendardBold
            default        : return .PretendardRegular
            }
        case .fSCoreDream:
            switch weight {
            case .regular  : return .SCoreDream4Regular
            case .semibold : return .SCoreDream6Bold
            case .bold     : return .SCoreDream7ExtraBold
            default        : return .SCoreDream4Regular
            }
        case .fSUIT:
            switch weight {
            case .regular  : return .SUITRegular
            case .semibold : return .SUITSemiBold
            case .bold     : return .SUITBold
            default        : return .SUITRegular
            }
        case .fThonburi:
            switch weight {
            case .regular  : return .ThonburiLight
            case .semibold : return .Thonburi
            case .bold     : return .ThonburiBold
            default        : return .Thonburi
            }
        case .fTtangsbudaejjigaeOTF:
            switch weight {
            case .regular  : return .OTTtangsbudaejjigaeL
            case .semibold : return .OTTtangsbudaejjigaeM
            case .bold     : return .OTTtangsbudaejjigaeB
            default        : return .OTTtangsbudaejjigaeL
            }
        case .fWantedSans:
            switch weight {
            case .regular  : return .WantedSansRegular
            case .semibold : return .WantedSansSemiBold
            case .bold     : return .WantedSansBold
            default        : return .WantedSansRegular
            }
        }

    }
}

enum ComponentFontCustomFontName: String, CaseIterable {
    case AmericanTypewriter         = "AmericanTypewriter"
    case AmericanTypewriterSemibold = "AmericanTypewriter-Semibold"
    case AmericanTypewriterBold     = "AmericanTypewriter-Bold"
    case AppleSDGothicNeoRegular    = "AppleSDGothicNeo-Regular"
    case AppleSDGothicNeoSemiBold   = "AppleSDGothicNeo-SemiBold"
    case AppleSDGothicNeoBold       = "AppleSDGothicNeo-Bold"
    case ChalkboardSERegular        = "ChalkboardSE-Regular"
    case ChalkboardSELight          = "ChalkboardSE-Light"
    case ChalkboardSEBold           = "ChalkboardSE-Bold"
    case CookieRunOTFRegular        = "CookieRunOTF-Regular"
    case CookieRunOTFBold           = "CookieRunOTF-Bold"
    case CookieRunOTFBlack          = "CookieRunOTF-Black"
    case Damascus                   = "Damascus"
    case DamascusSemiBold           = "DamascusSemiBold"
    case DamascusBold               = "DamascusBold"
    case DongleRegular              = "Dongle-Regular"
    case DongleLight                = "Dongle-Light"
    case DongleBold                 = "Dongle-Bold"
    case Freesentation4Regular      = "Freesentation-4Regular"
    case Freesentation6SemiBold     = "Freesentation-6SemiBold"
    case Freesentation7Bold         = "Freesentation-7Bold"
    case GaeguRegular               = "Gaegu-Regular"
    case GaeguLight                 = "Gaegu-Light"
    case GaeguBold                  = "Gaegu-Bold"
    case GothicA1Regular            = "GothicA1-Regular"
    case GothicA1SemiBold           = "GothicA1-SemiBold"
    case GothicA1Bold               = "GothicA1-Bold"
    case HahmletRegular             = "Hahmlet-Regular"
    case HahmletSemiBold            = "Hahmlet-SemiBold"
    case HahmletBold                = "Hahmlet-Bold"
    case HelveticaNeue              = "HelveticaNeue"
    case HelveticaNeueMedium        = "HelveticaNeue-Medium"
    case HelveticaNeueBold          = "HelveticaNeue-Bold"
    case IBMPlexSansKRRegular       = "IBMPlexSansKR-Regular"
    case IBMPlexSansKRSemiBold      = "IBMPlexSansKR-SemiBold"
    case IBMPlexSansKRBold          = "IBMPlexSansKR-Bold"
    case InteropRegular             = "Interop-Regular"
    case InteropSemiBold            = "Interop-SemiBold"
    case InteropBold                = "Interop-Bold"
    case KohinoorBanglaRegular      = "KohinoorBangla-Regular"
    case KohinoorBanglaLight        = "KohinoorBangla-Light"
    case KohinoorBanglaSemibold     = "KohinoorBangla-Semibold"
    case KohinoorDevanagariRegular  = "KohinoorDevanagari-Regular"
    case KohinoorDevanagariLight    = "KohinoorDevanagari-Light"
    case KohinoorDevanagariSemibold = "KohinoorDevanagari-Semibold"
    case KohinoorGujaratiRegular    = "KohinoorGujarati-Regular"
    case KohinoorGujaratiLight      = "KohinoorGujarati-Light"
    case KohinoorGujaratiBold       = "KohinoorGujarati-Bold"
    case KohinoorTeluguRegular      = "KohinoorTelugu-Regular"
    case KohinoorTeluguLight        = "KohinoorTelugu-Light"
    case KohinoorTeluguMedium       = "KohinoorTelugu-Medium"
    case LINESeedSansKRRegular      = "LINESeedSansKR-Regular"
    case LINESeedSansKRThin         = "LINESeedSansKR-Thin"
    case LINESeedSansKRBold         = "LINESeedSansKR-Bold"
    case MangoDdobakB               = "MangoDdobak-B"
    case MangoDdobakL               = "MangoDdobak-L"
    case MangoDdobakR               = "MangoDdobak-R"
    case MoveSansLight              = "MoveSans-Light"
    case MoveSansMedium             = "MoveSans-Medium"
    case MoveSansBold               = "MoveSans-Bold"
    case MuktaMaheeRegular          = "MuktaMahee-Regular"
    case MuktaMaheeLight            = "MuktaMahee-Light"
    case MuktaMaheeBold             = "MuktaMahee-Bold"
    case NotoSansKannadaRegular     = "NotoSansKannada-Regular"
    case NotoSansKannadaLight       = "NotoSansKannada-Light"
    case NotoSansKannadaBold        = "NotoSansKannada-Bold"
    case NotoSansMyanmarRegular     = "NotoSansMyanmar-Regular"
    case NotoSansMyanmarLight       = "NotoSansMyanmar-Light"
    case NotoSansMyanmarBold        = "NotoSansMyanmar-Bold"
    case PretendardRegular          = "Pretendard-Regular"
    case PretendardSemiBold         = "Pretendard-SemiBold"
    case PretendardBold             = "Pretendard-Bold"
    case SCoreDream4Regular         = "S-CoreDream-4Regular"
    case SCoreDream6Bold            = "S-CoreDream-6Bold"
    case SCoreDream7ExtraBold       = "S-CoreDream-7ExtraBold"
    case SUITRegular                = "SUIT-Regular"
    case SUITSemiBold               = "SUIT-SemiBold"
    case SUITBold                   = "SUIT-Bold"
    case Thonburi                   = "Thonburi"
    case ThonburiLight              = "Thonburi-Light"
    case ThonburiBold               = "Thonburi-Bold"
    case OTTtangsbudaejjigaeL       = "OTTtangsbudaejjigaeL"
    case OTTtangsbudaejjigaeM       = "OTTtangsbudaejjigaeM"
    case OTTtangsbudaejjigaeB       = "OTTtangsbudaejjigaeB"
    case WantedSansRegular          = "WantedSans-Regular"
    case WantedSansSemiBold         = "WantedSans-SemiBold"
    case WantedSansBold             = "WantedSans-Bold"
}

public enum ComponentFont: CaseIterable {
    case r08px, sb08px, b08px
    case r09px, sb09px, b09px
    case r10px, sb10px, b10px
    case r11px, sb11px, b11px
    case r12px, sb12px, b12px
    case r13px, sb13px, b13px
    case r14px, sb14px, b14px
    case r15px, sb15px, b15px
    case r16px, sb16px, b16px
    case r17px, sb17px, b17px
    case r18px, sb18px, b18px
    case r19px, sb19px, b19px
    case r20px, sb20px, b20px
    case r21px, sb21px, b21px
    case r22px, sb22px, b22px
    case r23px, sb23px, b23px
    case r24px, sb24px, b24px
    case r25px, sb25px, b25px
    case r26px, sb26px, b26px
    case r27px, sb27px, b27px
    case r28px, sb28px, b28px
    case r29px, sb29px, b29px
    case r30px, sb30px, b30px
    case r31px, sb31px, b31px
    case r32px, sb32px, b32px
    case r33px, sb33px, b33px
    case r34px, sb34px, b34px
}

public extension ComponentFont {

    static func font(weight: UIFont.Weight, size: CGFloat) -> UIFont {
        if let fontFamilyName = SharedPreference.shared.getStringtValue(forKey: .kSettingFontFamilyName),
           let familyType = ComponentFontCustomFamilyName(rawValue: fontFamilyName) {
            if let cumstomFont = UIFont.init(name: familyType.fontName(weight:weight).rawValue, size: size) {
                return cumstomFont
            }
        }
        return UIFont.systemFont(ofSize: size, weight: weight)
    }

    var font: UIFont {
        if let fontFamilyName = SharedPreference.shared.getStringtValue(forKey: .kSettingFontFamilyName),
           let familyType = ComponentFontCustomFamilyName(rawValue: fontFamilyName) {
            if let cumstomFont = UIFont.init(name: familyType.fontName(weight: self.weight).rawValue, size: self.fontSize) {
                return cumstomFont
            }
        }
        return UIFont.systemFont(ofSize: self.fontSize, weight: self.weight)
    }

    var fontSize: CGFloat {
        switch self {
        case .r08px, .sb08px, .b08px:
            return 8.0
        case .r09px, .sb09px, .b09px:
            return 9.0
        case .r10px, .sb10px, .b10px:
            return 10.0
        case .r11px, .sb11px, .b11px:
            return 11.0
        case .r12px, .sb12px, .b12px:
            return 12.0
        case .r13px, .sb13px, .b13px:
            return 13.0
        case .r14px, .sb14px, .b14px:
            return 14.0
        case .r15px, .sb15px, .b15px:
            return 15.0
        case .r16px, .sb16px, .b16px:
            return 16.0
        case .r17px, .sb17px, .b17px:
            return 17.0
        case .r18px, .sb18px, .b18px:
            return 18.0
        case .r19px, .sb19px, .b19px:
            return 19.0
        case .r20px, .sb20px, .b20px:
            return 20.0
        case .r21px, .sb21px, .b21px:
            return 21.0
        case .r22px, .sb22px, .b22px:
            return 22.0
        case .r23px, .sb23px, .b23px:
            return 23.0
        case .r24px, .sb24px, .b24px:
            return 24.0
        case .r25px, .sb25px, .b25px:
            return 25.0
        case .r26px, .sb26px, .b26px:
            return 26.0
        case .r27px, .sb27px, .b27px:
            return 27.0
        case .r28px, .sb28px, .b28px:
            return 28.0
        case .r29px, .sb29px, .b29px:
            return 29.0
        case .r30px, .sb30px, .b30px:
            return 30.0
        case .r31px, .sb31px, .b31px:
            return 31.0
        case .r32px, .sb32px, .b32px:
            return 32.0
        case .r33px, .sb33px, .b33px:
            return 33.0
        case .r34px, .sb34px, .b34px:
            return 34.0
        }
    }

    var lineHeight: CGFloat {
        return self.fontLineHeight
    }

    /*
     lineHeight = ascent + descent + leading
     - ascent: 글자의 윗부분
     - descent : baseline 밑 부분
     - leading : vertical spacing
     */

    var fontLineHeight: CGFloat {
        return self.font.lineHeight
    }

    var fontAscender: CGFloat {
        return self.font.ascender
    }

    var fontDescender: CGFloat {
        return self.font.descender
    }
    
    var fontLeading: CGFloat {
        return self.font.leading
    }

    var weight: UIFont.Weight {
        switch self {
        case .b08px, .b09px, .b10px, .b11px, .b12px, .b13px, .b14px,
                .b15px, .b16px, .b17px, .b18px, .b19px,
                .b20px, .b21px, .b22px, .b23px, .b24px,
                .b25px, .b26px, .b27px, .b28px, .b29px,
                .b30px, .b31px, .b32px, .b33px, .b34px
            :
            return .bold
        case .sb08px, .sb09px, .sb10px, .sb11px, .sb12px, .sb13px, .sb14px,
                .sb15px, .sb16px, .sb17px, .sb18px, .sb19px,
                .sb20px, .sb21px, .sb22px, .sb23px, .sb24px,
                .sb25px, .sb26px, .sb27px, .sb28px, .sb29px,
                .sb30px, .sb31px, .sb32px, .sb33px, .sb34px
            :
            return .semibold
        case .r08px, .r09px, .r10px, .r11px, .r12px, .r13px, .r14px,
                .r15px, .r16px, .r17px, .r18px, .r19px,
                .r20px, .r21px, .r22px, .r23px, .r24px,
                .r25px, .r26px, .r27px, .r28px, .r29px,
                .r30px, .r31px, .r32px, .r33px, .r34px
            :
            return .regular
        }
    }
}

extension String {
    func toAttributed(fontType: ComponentFont,
                      lineHeight: CGFloat? = nil,
                      color: UIColor?,
                      underLine: Bool = false,
                      alignment: NSTextAlignment = .left,
                      lineBreakMode: NSLineBreakMode = .byWordWrapping) -> NSMutableAttributedString {

        var baselineValue: CGFloat = 0
        let style = NSMutableParagraphStyle()
        style.alignment = alignment
        style.lineBreakMode = lineBreakMode
        if let lineHeight = lineHeight {
            if lineHeight == 0 {
                style.lineSpacing = 0
            } else {
                style.maximumLineHeight = lineHeight
                style.minimumLineHeight = lineHeight
                if lineHeight > fontType.fontSize {
                    baselineValue = ((lineHeight - fontType.fontLineHeight) / 4)
                }
            }
        } else {
            style.maximumLineHeight = fontType.lineHeight
            style.minimumLineHeight = fontType.lineHeight
            baselineValue = ((fontType.lineHeight - fontType.fontLineHeight) / 4)
        }

        var attributes: [NSAttributedString.Key: Any] = [
                            .paragraphStyle: style,
                            .baselineOffset: baselineValue,
                            .font: fontType.font,
                            .foregroundColor: (color ?? .white)
        ]

        if underLine {
            attributes[.baselineOffset] = 4
            attributes[.underlineStyle] = NSUnderlineStyle.single.rawValue
        }

        return NSMutableAttributedString(string: self, attributes: attributes)
    }
}
