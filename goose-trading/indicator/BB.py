def get_bollinger_band(df, w=20, k=2):
    df["mbb"] = df["close"].rolling(w).mean()
    df["std"] = df["close"].rolling(w).std()
    df["ubb"]= df.apply(lambda x: x["mbb"] + k*x["std"], axis=1)
    df["lbb"]= df.apply(lambda x: x["mbb"] - k*x["std"], axis=1)

    return {
        "ubb": df["ubb"],
        "lbb": df["lbb"]
    }