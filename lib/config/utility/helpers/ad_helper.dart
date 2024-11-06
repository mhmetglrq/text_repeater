import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/material.dart';

class AdMobHelper {
  static final AdMobHelper _instance = AdMobHelper._internal();

  factory AdMobHelper() {
    return _instance;
  }

  AdMobHelper._internal();

  late BannerAd _bannerAd;
  bool _isBannerAdLoaded = false;

  late RewardedInterstitialAd _rewardedInterstitialAd;
  bool _isRewardedInterstitialAdLoaded = false;

  void initialize() {
    MobileAds.instance.initialize();
    loadBannerAd();
    loadRewardedInterstitialAd();
  }

  /// Banner Ad yükleyici ve gösterici
  void loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId:
          'ca-app-pub-1137260032650081/4363002633', // Banner Ad Unit ID girin
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          _isBannerAdLoaded = true;
          print("Banner Ad Yüklendi");
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
          print("Banner Ad Yüklenemedi: $error");
          _isBannerAdLoaded = false;
        },
      ),
    )..load();
  }

  Widget getBannerAdWidget() {
    if (_isBannerAdLoaded) {
      return Container(
        alignment: Alignment.center,
        width: _bannerAd.size.width.toDouble(),
        height: _bannerAd.size.height.toDouble(),
        child: AdWidget(ad: _bannerAd),
      );
    } else {
      loadBannerAd(); // Eğer reklam yüklenmemişse tekrar yükler
      return const SizedBox.shrink();
    }
  }

  /// Rewarded Interstitial Ad yükleyici
  void loadRewardedInterstitialAd() {
    RewardedInterstitialAd.load(
      adUnitId:
          'ca-app-pub-1137260032650081/6579209651', // Rewarded Ad Unit ID girin
      request: const AdRequest(),
      rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
        onAdLoaded: (RewardedInterstitialAd ad) {
          _rewardedInterstitialAd = ad;
          _isRewardedInterstitialAdLoaded = true;
          print("Rewarded Interstitial Ad Yüklendi");
        },
        onAdFailedToLoad: (LoadAdError error) {
          print("Rewarded Interstitial Ad Yüklenemedi: $error");
          _isRewardedInterstitialAdLoaded = false;
        },
      ),
    );
  }

  /// Rewarded Interstitial Ad gösterici
  void showRewardedInterstitialAd(
      {required Function onRewarded, required Function onDismissed}) {
    if (_isRewardedInterstitialAdLoaded) {
      _rewardedInterstitialAd.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
          print("Kullanıcı ödüllendirildi: ${reward.amount} ${reward.type}");
          onRewarded(); // Ödül işlemlerini burada yapabilirsiniz
        },
      );

      _rewardedInterstitialAd.fullScreenContentCallback =
          FullScreenContentCallback(
        onAdDismissedFullScreenContent: (RewardedInterstitialAd ad) {
          onDismissed();
          ad.dispose();
          loadRewardedInterstitialAd(); // Reklam kapandıktan sonra yeni reklamı yükler
        },
        onAdFailedToShowFullScreenContent:
            (RewardedInterstitialAd ad, AdError error) {
          ad.dispose();
          loadRewardedInterstitialAd(); // Reklam gösterimi başarısız olursa tekrar yükler
        },
      );
    } else {
      print("Rewarded Interstitial Ad Henüz Yüklenmedi");
      loadRewardedInterstitialAd();
    }
  }

  void dispose() {
    if (_isBannerAdLoaded) {
      _bannerAd.dispose();
    }
    if (_isRewardedInterstitialAdLoaded) {
      _rewardedInterstitialAd.dispose();
    }
  }
}
