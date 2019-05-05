using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace CastleDefenderPMG
{
    public partial class Form1 : Form
    {
        Bitmap pmgmap;
        bool myPen; //whether pen is up or down (true = down)
        byte[] pmgdata = new byte[1024];
        int lastX = 0, lastY = 0;
        int xkernsize = 16; //pixel size
        int ykernsize = 16; //vertical cursor(pixel) size 

        public Form1()
        {
            InitializeComponent();
            InitPMG();
        }

        private void InitPMG()
        {
            for (int i = 0; i < pmgdata.Length; i++)
                pmgdata[i] = 0;
            pmgmap = new Bitmap(pictureBox1.Width, pictureBox1.Height, System.Drawing.Imaging.PixelFormat.Format32bppArgb);
            pictureBox2.Image = pmgmap;
        }

        private void buttonLoadImage_Click(object sender, EventArgs e)
        {
            LoadImage();
        }

        private void LoadImage()
        {
            if (openFileDialog1.ShowDialog() == DialogResult.OK)
            {
                pictureBox1.ImageLocation = openFileDialog1.FileName;
            }
        }

        private void pictureBox1_LoadCompleted(object sender, AsyncCompletedEventArgs e)
        {
            pictureBox1.Size = new Size(pictureBox1.Image.Width, pictureBox1.Image.Height);
            pictureBox2.Left = 8; // pictureBox1.Left;
            pictureBox2.Top = 0; // pictureBox1.Top;
            pictureBox2.Size = pictureBox1.Size;
            pmgmap = new Bitmap(pictureBox1.Width, pictureBox1.Height, System.Drawing.Imaging.PixelFormat.Format32bppArgb);
            pictureBox2.BackColor = Color.Transparent; //Color.Green;
            pictureBox2.Image = pmgmap;
            pictureBox2.Parent = pictureBox1;
            pictureBox1.SizeMode = PictureBoxSizeMode.Zoom;
        }

        private int MyFloor(double value)
        {
            return (int)Math.Floor(value);
        }

        private void pictureBox2_MouseDown(object sender, MouseEventArgs e)
        {
            lastX = MyFloor(e.X / xkernsize) * xkernsize;
            lastY = MyFloor(e.Y / ykernsize) * ykernsize;
            if (e.Button == MouseButtons.Left)
                myPen = true;

            if (e.Button == MouseButtons.Right)
                myPen = false;


            SetPoint(lastX, lastY);
        }

        private void pictureBox2_MouseLeave(object sender, EventArgs e)
        {
            myPen = false;
        }

        private void pictureBox2_MouseUp(object sender, MouseEventArgs e)
        {
            myPen = false;
        }

        private void SetPoint(int px, int py)
        {
            if (px < 0 || py < 0 || px > pictureBox1.Width - xkernsize || py > pictureBox1.Height - ykernsize)
                return;

            int mx = MyFloor(px / xkernsize) - 7;
            int my = MyFloor(py / ykernsize);

            if (mx < 0 || my < 0 || mx > 31 || my > 256)
                return;

            SetPixel(px, py);
            pictureBox2.Image = pmgmap;
            lastX = px;
            lastY = py;
            SetPMG(mx, my);
        }


        private void SetPixel(int x, int y)
        {
            Color myColor = myPen ? Color.FromArgb(128, Color.Red) : Color.FromArgb(0, Color.White);
            for (int i = 0; i < xkernsize; i++)
                for (int j = 0; j < ykernsize; j++)
                {
                    pmgmap.SetPixel(x + i, y + j, myColor);
                }
        }

        private void UnsetPoint(int px, int py)
        {
            myPen = false;
            SetPoint(px, py);
        }
    
        private void SetPMG(int mx, int my)
        {
            //Console.WriteLine("mx,my: " + mx.ToString() + "," + my.ToString());

            int x = mx;
            int y = my;
            int bitIndex = 7 - (x % 8);
            uint bitValue = (uint)1 << bitIndex;
            int pmgno = MyFloor(x / 8);

            if (myPen)
            {
                for (int i = 0; i < ykernsize / 2; i++)
                {
                    pmgdata[pmgno * 256 + y*ykernsize/2 + i] |= (byte)bitValue;
                }
            }
            else
            {
                for (int i = 0; i < ykernsize / 2; i++)
                {
                    pmgdata[pmgno * 256 + y*ykernsize/2 + i] &= (byte)(255 - bitValue);
                }
            }
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            comboBox1.SelectedIndex = 0;
        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                ykernsize = 2 * Int32.Parse(comboBox1.SelectedItem.ToString());
            } catch (Exception ex)
            {
                Console.WriteLine(comboBox1.SelectedText);
            }
            }

        private void buttonSavePMG_Click(object sender, EventArgs e)
        {
            if (saveFileDialog1.ShowDialog() == DialogResult.OK)
            {
                SavePMG(saveFileDialog1.FileName);
            }
        }

        private void SavePMG(string filename)
        {
            File.WriteAllBytes(filename, pmgdata);
        }

        private void LoadPMG(string filename)
        {
            pmgdata = File.ReadAllBytes(filename);
        }

        private void buttonLoadPMG_Click(object sender, EventArgs e)
        {
            if (openFileDialog1.ShowDialog() == DialogResult.OK)
            {
                InitPMG();
                LoadPMG(openFileDialog1.FileName);
                RedrawPMG();
            }
        }

        private void RedrawPMG()
        {
            int oldyks = ykernsize;
            ykernsize = 2; //size of 1 pixel drawn vertically
            myPen = true;
            
            for (int i = 0; i < 4; i++)
                for (int j = 0; j < 256; j++)
                {
                    byte myByte = pmgdata[i * 256 + j];
                    for (int k = 7; k > -1; k--)
                    {
                        if (myByte >= 128)
                        {
                            SetPoint((7 + i * 8 + 7 - k) * xkernsize, j * ykernsize);
                            //pictureBox2.Refresh();
                            //System.Threading.Thread.Sleep(10);
                            myByte -= 128;
                        }
                        myByte <<= 1; //shift value left
                    }
                }

            ykernsize = oldyks;
            myPen = false;
        }

        private void buttonClearPMG_Click(object sender, EventArgs e)
        {
            InitPMG();
            RedrawPMG();
        }

        private void buttonFrame_Click(object sender, EventArgs e)
        {
            Graphics gr = pictureBox2.CreateGraphics();
            gr.DrawRectangle(new Pen(Color.White), 0, 0, pictureBox2.Width - 1, pictureBox2.Height - 1);
            
        }

        private void numericUpDown1_ValueChanged(object sender, EventArgs e)
        {
            pictureBox2.Left = (int)numericUpDown1.Value;
        }

        private void buttonInverse_Click(object sender, EventArgs e)
        {
            pmgmap = new Bitmap(pictureBox1.Width, pictureBox1.Height, System.Drawing.Imaging.PixelFormat.Format32bppArgb);
            pictureBox2.Image = pmgmap;

            for (int i = 0; i < pmgdata.Length; i++)
                pmgdata[i] = (byte)(255 - pmgdata[i]);
            RedrawPMG();
        }

        private void pictureBox2_MouseMove(object sender, MouseEventArgs e)
        {
            int currX = MyFloor(e.X / xkernsize) * xkernsize;
            int currY = MyFloor(e.Y / ykernsize) * ykernsize;

            if (currX == lastX && currY == lastY)
            {
                //do nothing
            }
            else
            {
                if (e.Button == MouseButtons.Left)
                {
                    SetPoint(currX, currY);
                }

                if (e.Button == MouseButtons.Right)
                {
                    UnsetPoint(currX, currY);
                }
            }
        }
    }
}
