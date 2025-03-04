import pandas as pd
import os

def combine_csv_files(file_list):
    combined_df = pd.DataFrame()
    
    for file in file_list:
        df = pd.read_csv(file)
        combined_df = pd.concat([combined_df, df], ignore_index=True)
    
    return combined_df

def clean_data(df):
    cleaned_df = df.dropna(subset=['transaction_id', 'date', 'customer_id']).copy()
    
    cleaned_df['date'] = pd.to_datetime(cleaned_df['date'])
    
    cleaned_df = cleaned_df.sort_values('date', ascending=False)
    cleaned_df = cleaned_df.drop_duplicates(subset=['transaction_id'], keep='first')
    
    return cleaned_df

def calculate_sales_per_branch(df):
    df['total_sales'] = df['price'] * df['quantity']
    
    sales_per_branch = df.groupby('branch')['total_sales'].sum().reset_index()
    
    return sales_per_branch

def save_to_csv(df):
    output_dir = "output"
    os.makedirs(output_dir, exist_ok=True)
    
    file_path = os.path.join(output_dir, "total_sales_per_branch.csv")
    df.to_csv(file_path, index=False)
    print(f"Data saved to {file_path}")

def main():
    file_list = ['./data/branch_a.csv', './data/branch_b.csv', './data/branch_c.csv']
    
    combined_data = combine_csv_files(file_list)
    
    cleaned_data = clean_data(combined_data)
    
    sales_per_branch = calculate_sales_per_branch(cleaned_data)

    save_to_csv(sales_per_branch)

if __name__ == "__main__":
    main()