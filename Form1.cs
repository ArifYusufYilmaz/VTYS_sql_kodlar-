using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Npgsql;

namespace G171210063_vtys
{
    public partial class Form1 : Form
    {
       
        public Form1()
        {
             
            InitializeComponent();
        }
        private void databaseDeclaration(string komut)
        {
            try
            {
                string connstring = "Server=127.0.0.1; Port=5432; User Id=postgres; Password=0508; Database=Proje;";
                NpgsqlConnection connection = new NpgsqlConnection(connstring);
                connection.Open();

                NpgsqlCommand command = new NpgsqlCommand(komut, connection);
                command.ExecuteNonQuery();
                connection.Close();
            }
            catch (Exception msg)
            {
                MessageBox.Show(msg.ToString());
                throw;
            }
        }

      

        private void button2_Click(object sender, EventArgs e)  // ARA - LİSTELE
        {
            richTextBox1.Clear();
            try
            {
                string connstring = "Server=127.0.0.1; Port=5432; User Id=postgres; Password=0508; Database=Proje;";
                NpgsqlConnection connection = new NpgsqlConnection(connstring);
                connection.Open();
                string yazar = "SELECT * FROM " + '"' + "public" + '"' + '.' + '"' + "Yurt" + '"';
                NpgsqlCommand command = new NpgsqlCommand(yazar, connection);
                NpgsqlDataReader dataReader = command.ExecuteReader();
                for (int i = 0; dataReader.Read(); i++)
                {
                    richTextBox1.Text += "yurtId: " + dataReader[0].ToString() + "  blokNo: " + dataReader[1].ToString() + "\n\n";
                }
                connection.Close();
            }
            catch (Exception msg)
            {
                MessageBox.Show(msg.ToString());
                throw;
            }
        }
        private void button1_Click(object sender, EventArgs e) //  YURT EKLEME
        {
            string komut = " SELECT *from yurtekle(" + maskedTextBox1.Text + "," + maskedTextBox2.Text + ");";
            databaseDeclaration(komut);

        }

        private void button4_Click(object sender, EventArgs e) // YURT GUNCELLE
        {
            string komut = "SELECT *from updateyurt(" + maskedTextBox1.Text + "," + maskedTextBox2.Text + ");";   // * düzenleme yapmalısın. where?
            databaseDeclaration(komut);

        }

        private void button7_Click(object sender, EventArgs e) // YURT SİL
        {

            string yazar = "SELECT *from yurtsil(" + maskedTextBox2.Text + ")";
            databaseDeclaration(yazar);
        }



        private void button5_Click(object sender, EventArgs e) // Trigger OGRENCİ EKLE
        {
            
                string komut = " SELECT *from ogrenciekle(" + maskedTextBox8.Text + "," + maskedTextBox9.Text + "," + maskedTextBox10.Text + ");";
                databaseDeclaration(komut);
        
        }

        private void button6_Click(object sender, EventArgs e) // trigger ucret ode 
        {
            string komut = " SELECT *from ucretode(" + maskedTextBox3.Text + "," + maskedTextBox4.Text + ");";
            databaseDeclaration(komut);

        }



        private void button3_Click(object sender, EventArgs e) // Trigger Ogrenci Sİl
        {
            string komut = " SELECT *from ogrencisil(" + maskedTextBox5.Text + ");";
            databaseDeclaration(komut);
        }

        private void button8_Click(object sender, EventArgs e) // Trigger izin ekle
        {

            string komut = " SELECT *from izinekle(" + maskedTextBox6.Text + "," + maskedTextBox7.Text + "," + maskedTextBox11.Text + ");";
            databaseDeclaration(komut);
        } 
        
        
        
        
        
        
        
        private void Form1_Load(object sender, EventArgs e)
        {

        }

        private void label1_Click(object sender, EventArgs e)
        {

        }
    }
}
