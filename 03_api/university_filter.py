import os
import requests
import pandas as pd

def fetch_universities(country: str, limit=500):
    url = "http://universities.hipolabs.com/search"
    all_data = []
    offset = 0

    while True:
        params = {"country": country, "limit": limit, "offset": offset}
        try:
            response = requests.get(url, params=params, timeout=10)
            if response.status_code != 200:
                raise Exception("Failed to fetch data from API")
            
            data = response.json()
            if not data:
                break  

            all_data.extend(data)
            offset += limit  

        except requests.exceptions.RequestException as e:
            print(f"Error fetching data: {e}")
            break  

    return all_data

def process_data(data):
    df = pd.DataFrame(data)
    if not df.empty:
        df = df[["name", "web_pages", "country", "domains", "state-province"]]
        df.columns = ["Name", "Web pages", "Country", "Domains", "State Province"]
        df = df.dropna(subset=["State Province"])  
    
    return df

def save_to_csv(df, country):
    output_dir = "output"
    os.makedirs(output_dir, exist_ok=True)
    
    file_path = os.path.join(output_dir, f"{country}_universities.csv")
    df.to_csv(file_path, index=False, encoding="utf-8")
    print(f"Data saved to {file_path}")

def main():
    country = input("Enter country name: ")
    data = fetch_universities(country)
    df = process_data(data)
    
    if not df.empty:
        save_to_csv(df, country)
    else:
        print("No data found for the given country.")

if __name__ == "__main__":
    main()
